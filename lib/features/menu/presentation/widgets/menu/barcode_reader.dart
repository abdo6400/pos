import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../bloc/cubit/barcode_reader_cubit.dart';

class BarcodeReader extends StatelessWidget {
  const BarcodeReader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarcodeReaderCubit, bool>(
      listener: (context, state) {},
      builder: (context, scan) {
        return VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            context
                .read<BarcodeReaderCubit>()
                .setVisibility(info.visibleFraction > 0);
          },
          key: Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
              bufferDuration: Duration(milliseconds: 200),
              onBarcodeScanned: (barcode) {
                if (!scan) return;
                print(barcode);
              },
              child: Icon(
                Icons.barcode_reader,
                color: scan
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
              )),
        );
      },
    );
  }
}
