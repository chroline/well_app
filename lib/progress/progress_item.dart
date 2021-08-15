import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressItem extends StatelessWidget {
  final String title;
  final double value;

  const ProgressItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Checkbox(
                onChanged: (bool? value) {},
                value: value >= 1,
                fillColor: MaterialStateProperty.all(Colors.teal),
              ),
              Text(title, style: Theme.of(context).textTheme.bodyText2)
            ],
          ),
          LinearProgressIndicator(
            value: value == 0 ? null : value,
            valueColor: AlwaysStoppedAnimation(
                Colors.teal.withOpacity(value == 0 ? 0.25 : 1)),
            backgroundColor: Colors.black12,
            minHeight: 5,
          ),
          const SizedBox(height: 20)
        ],
      );
}
