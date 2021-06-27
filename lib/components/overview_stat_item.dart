import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverviewStatItem extends StatelessWidget {
  final int amnt;
  final String desc;

  const OverviewStatItem({Key? key, required this.amnt, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: amnt.toString() + ' ',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 36,
                fontFeatures: [const FontFeature.tabularFigures()],
                fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                  text: desc,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      )),
            ],
          ),
        ),
      ) /* Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: ,
          ),
        ),
      ) */
      ;
}
