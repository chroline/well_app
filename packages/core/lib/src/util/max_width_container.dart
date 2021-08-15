import 'package:flutter/material.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 700),
                child: child),
          )
        ],
      );
}
