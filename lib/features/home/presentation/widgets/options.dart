import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      shape: BorderDirectional(
        top: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
      ),
      child: Row(
          children: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
              .map((e) => Flexible(
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: Text(e),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
