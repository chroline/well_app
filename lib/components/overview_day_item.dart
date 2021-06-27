import 'package:flutter/material.dart';

class OverviewDayItem extends StatelessWidget {
  final int dayNum;
  final double percentCompletion;

  const OverviewDayItem(
      {Key? key, required this.dayNum, required this.percentCompletion})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade100,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                value: percentCompletion,
                color: Colors.teal,
                strokeWidth: 10,
              ),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: Text(
                  dayNum.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal),
                ),
              ),
            )
          ],
        ),
      );
}
