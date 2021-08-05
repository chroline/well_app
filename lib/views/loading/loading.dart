import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade50,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
