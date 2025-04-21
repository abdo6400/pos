package com.futec.retail

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import androidx.annotation.NonNull
import com.imin.library.IminSDKManager
import com.imin.library.SystemPropManager
import com.imin.printerlib.IminPrintUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets

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
            }
        }
    }
}
