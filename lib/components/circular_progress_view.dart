import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressView extends StatelessWidget {
  final double value;
  final String title;
  final String subtitle;
  final Color color;

  const CircularProgressView(
      {Key? key,
      required this.value,
      required this.title,
      required this.subtitle,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(
              value: value == 0 ? null : value,
              valueColor: AlwaysStoppedAnimation(
                  color.withOpacity(value == 0 ? 0.25 : 1)),
              backgroundColor: Colors.black12,
              strokeWidth: value == 0 ? 5 : 15,
            ),
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: color, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black))
              ],
            ),
          )
        ],
      );
}
