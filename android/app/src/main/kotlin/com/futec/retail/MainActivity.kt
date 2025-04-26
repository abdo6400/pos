package com.futec.retail

import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import androidx.annotation.NonNull
import com.imin.library.IminSDKManager
import com.imin.library.SystemPropManager
import com.imin.printerlib.IminPrintUtils
import com.rt.printerlibrary.bean.BluetoothEdrConfigBean
import com.rt.printerlibrary.cmd.Cmd
import com.rt.printerlibrary.cmd.EscFactory
import com.rt.printerlibrary.connect.PrinterInterface
import com.rt.printerlibrary.enumerate.BmpPrintMode
import com.rt.printerlibrary.enumerate.CommonEnum
import com.rt.printerlibrary.exception.SdkException
import com.rt.printerlibrary.factory.cmd.CmdFactory
import com.rt.printerlibrary.factory.connect.BluetoothFactory
import com.rt.printerlibrary.factory.connect.PIFactory
import com.rt.printerlibrary.factory.printer.PrinterFactory
import com.rt.printerlibrary.factory.printer.ThermalPrinterFactory
import com.rt.printerlibrary.printer.RTPrinter
import com.rt.printerlibrary.setting.BitmapSetting
import com.rt.printerlibrary.setting.CommonSetting
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets
import java.util.ArrayList

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.futec.retail"
    private var scanResult: MethodChannel.Result? = null
    private var connectType = IminPrintUtils.PrintConnectType.USB

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "sdkInit" -> {
                    val deviceModel = SystemPropManager.getModel()
                    if (deviceModel.contains("M")) {
                        connectType = IminPrintUtils.PrintConnectType.SPI
                    }
                    IminPrintUtils.getInstance(this@MainActivity).initPrinter(connectType)
                    result.success("init")
                }
                "getStatus" -> {
                    val status = IminPrintUtils.getInstance(this@MainActivity).getPrinterStatus(connectType)
                    result.success("$status")
                }
                "printImage" -> {
                    if (call.arguments == null) return@setMethodCallHandler
                    val charset: Charset = StandardCharsets.UTF_8
                    val mIminPrintUtils = IminPrintUtils.getInstance(this@MainActivity)
                    val data = call.arguments as ByteArray
                    val bitmap = BitmapFactory.decodeByteArray(data, 0, data.size)
                    mIminPrintUtils.printSingleBitmap(bitmap)
                    mIminPrintUtils.printAndFeedPaper(100)
                    IminPrintUtils.getInstance(this@MainActivity).partialCut()
                }
                "printText" -> {
                    if (call.arguments == null) return@setMethodCallHandler
                    val text = (call.arguments as List<*>)[0].toString()
                    val mIminPrintUtils = IminPrintUtils.getInstance(this@MainActivity)
                    mIminPrintUtils.printText("$text   \n")
                    result.success(text)
                }
                "getSn" -> {
                    val sn = if (Build.VERSION.SDK_INT >= 30) {
                        SystemPropManager.getSystemProperties("persist.sys.imin.sn")
                    } else {
                        SystemPropManager.getSn()
                    }
                    result.success(sn)
                }
                "opencashBox" -> {
                    IminSDKManager.opencashBox()
                    result.success("opencashBox")
                }
                PrinterStrings.connectCommand -> {
                    val printerMac = call.argument<String>(PrinterStrings.macArg)
                    if (printerMac != null) {
                        PrinterManager.connect(printerMac)
                    }
                }
                PrinterStrings.printCommand -> {
                    val imgPath = call.argument<String>(PrinterStrings.imgPathArg)
                    if (imgPath != null) {
                        PrinterManager.printImg(imgPath)
                    }
                }
            }
        }
    }
}

class PrinterStrings {
    companion object {
        // channel name
        const val channel = "android.flutter/printer"
        // commands
        const val connectCommand = "printer_connect"
        const val printCommand = "printer_print"
        // arguments
        const val macArg = "printer_mac"
        const val imgPathArg = "img_path"
    }
}

class PrintersWidth {
    companion object {
        const val mm_4inch = 104 // mm
        const val mm_3inch = 80
        const val mm_72 = 72 // mm
        const val px_3inch = 575 // mm
        const val px_4inch = 820 // mm
    }
}

class PrinterManager {
    companion object {
        private var rtPrinter: RTPrinter<Any>? = null
        private var mBluetoothAdapter: BluetoothAdapter? = null
        private var pairedDeviceList: List<BluetoothDevice> = ArrayList()

        @SuppressLint("MissingPermission")
        private fun initPrinter() {
            val printerFactory: PrinterFactory = ThermalPrinterFactory()
            rtPrinter = printerFactory.create()
            mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
            mBluetoothAdapter?.startDiscovery()
            pairedDeviceList = ArrayList(mBluetoothAdapter?.bondedDevices ?: emptySet())
        }

        private fun openPortWithDevice(device: BluetoothDevice) {
            val configObj = BluetoothEdrConfigBean(device)
            val bluetoothEdrConfigBean = configObj as BluetoothEdrConfigBean
            openPortWithDevice(bluetoothEdrConfigBean)
        }

        private fun openPortWithDevice(bluetoothEdrConfigBean: BluetoothEdrConfigBean): Int {
            return try {
                val piFactory: PIFactory = BluetoothFactory()
                val printerInterface: PrinterInterface<Any> = piFactory.create()
                rtPrinter?.setPrinterInterface(printerInterface)
                rtPrinter?.connect(bluetoothEdrConfigBean)
                0
            } catch (e: Exception) {
                e.printStackTrace()
                -1
            }
        }

        @SuppressLint("MissingPermission")
        fun connect(printerMac: String) {
            initPrinter()
            for (i in 0 until pairedDeviceList.size) {
                val dev = pairedDeviceList[i]
                if (dev.address == printerMac) {
                    mBluetoothAdapter?.cancelDiscovery()
                    openPortWithDevice(dev)
                }
            }
        }

        fun printImg(imgPath: String) {
            val mBitmap = BitmapFactory.decodeFile(imgPath)
            Thread {
                val cmdFactory: CmdFactory = EscFactory()
                val cmd: Cmd = cmdFactory.create()
                cmd.append(cmd.headerCmd)

                val commonSetting = CommonSetting()
                commonSetting.align = CommonEnum.ALIGN_MIDDLE
                cmd.append(cmd.getCommonSettingCmd(commonSetting))

                val bitmapSetting = BitmapSetting()
                bitmapSetting.bmpPrintMode = BmpPrintMode.MODE_SINGLE_COLOR
                bitmapSetting.bimtapLimitWidth = PrintersWidth.mm_3inch * 8

                try {
                    cmd.append(cmd.getBitmapCmd(bitmapSetting, mBitmap))
                } catch (e: SdkException) {
                    e.printStackTrace()
                }

                // Add line feeds using the proper command
                cmd.append(cmd.getLFCRCmd()) // Feed line command for line breaks
                cmd.append(cmd.getLFCRCmd())
                cmd.append(cmd.getLFCRCmd())
                cmd.append(cmd.getLFCRCmd())
                cmd.append(cmd.getLFCRCmd())
                cmd.append(cmd.getLFCRCmd())
                // Get connection state as string
                val connectionState = rtPrinter?.connectState?.toString()
                rtPrinter?.writeMsg(cmd.appendCmds) // Sync Write
            }.start()
        }
    }
}
