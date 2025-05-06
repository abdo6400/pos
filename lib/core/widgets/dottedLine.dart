import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

class DotLine extends StatelessWidget {

  const DotLine({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashLength: 4.0,
      lineThickness: 2.0,
      dashColor: Colors.black,
    );
  }
}