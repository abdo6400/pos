import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../bloc/cubit/barcode_reader_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';

class BarcodeReader extends StatelessWidget {
   final TextEditingController controller;
  const BarcodeReader(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarcodeReaderCubit, String?>(
      listener: (context, state) {
        if(state!=null){
          controller.setText(state);
          context.read<SearchCubit>().changeSearch(state);
        }
      },
      builder: (context, scan) {
        return  BarcodeKeyboardListener(
              bufferDuration: Duration(milliseconds: 200),
              onBarcodeScanned: (barcode) {
                context.read<BarcodeReaderCubit>().setVisibility(barcode);
              },
              child: Icon(
                Icons.barcode_reader,
                color:  Theme.of(context).colorScheme.secondary,
              )
        );
      },
    );
  }
}
