import 'package:flutter/material.dart';

class GratitudeItem extends StatelessWidget {
  final String text;

  const GratitudeItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('I am grateful...',
              style: Theme.of(context).textTheme.subtitle1),
          Text(text,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20)
        ],
      );
}
