import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/overview_day_item.dart';
import '../../../../components/overview_stat_item.dart';
import '../../../../services/day_collection.dart';
import '../../../../style.dart';
import '../../../../util/calculate_day_completion.dart';
import '../../../../util/partition.dart';

class OverviewTabPage extends StatelessWidget {
  final days = DayCollectionService.I.dayCollection$.valueWrapper!.value;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Overview',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  banner,
                  divider,
                  Text('Days', style: Style.I.textTheme.subtitle2),
                  const SizedBox(height: 20),
                  _OverviewDays(),
                  divider,
                  Text('Stats', style: Style.I.textTheme.subtitle2),
                  const SizedBox(height: 10),
                  _OverviewStats()
                ],
              ),
            ),
          ),
        ),
      ));

  Widget get banner => Material(
        color: days.length < 21
            ? days.length < 14
                ? Colors.indigo.shade50
                : Colors.orange.shade50
            : Colors.green.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        elevation: 1,
        child: InkWell(
          onTap: () {},
          splashColor: days.length < 21
              ? days.length < 14
                  ? Colors.indigo.shade100
                  : Colors.orange.shade100
              : Colors.green.shade100,
          overlayColor: MaterialStateProperty.all(Colors.indigo.shade100),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                'You are on day ${days.length} of 21! ' +
                    (days.length < 21
                        ? days.length < 14
                            ? 'Keep up the good work!'
                            : 'Final stretch!'
                        : 'You did it! Feel free to keep going.'),
                style: TextStyle(
                    color: Colors.indigo.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );

  Widget get divider => const Padding(
        padding: EdgeInsets.all(20),
        child: Divider(
          color: Colors.black26,
          thickness: 2,
        ),
      );
}

class _OverviewDays extends StatelessWidget {
  final days = DayCollectionService.I.dayCollection$.valueWrapper!.value;

  @override
  Widget build(BuildContext context) => Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        spacing: 20,
        runSpacing: 20,
        children: days
            .asMap()
            .entries
            .map((entry) => OverviewDayItem(
                  dayNum: entry.key + 1,
                  percentCompletion: calculateDayCompletion(entry.value),
                ))
            .toList()
            .partition(3)
            .map((partition) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: partition))
            .toList(),
      );
}

class _OverviewStats extends StatelessWidget {
  final days = DayCollectionService.I.dayCollection$.valueWrapper!.value;

  int get gratitudes => days.map((e) => e.gratitudes).expand((i) => i).length;
  int get journals =>
      days.map((e) => e.journal).where((e) => e != '' && e != null).length;
  int get acts => days.map((e) => e.acts).expand((i) => i).length;
  int get exercise => days.map((e) => e.exercise).reduce((a, b) => a + b);
  int get meditation => days.map((e) => e.meditation).reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) => SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverviewStatItem(
              amnt: gratitudes, desc: "gratitude${gratitudes == 1 ? "" : "s"}"),
          OverviewStatItem(
              amnt: acts, desc: "act${acts == 1 ? "" : "s"} of kindness"),
          OverviewStatItem(
              amnt: journals, desc: "journal${journals == 1 ? "" : "s"}"),
          OverviewStatItem(
              amnt: exercise,
              desc: "minute${exercise == 1 ? "" : "s"} of exercise"),
          OverviewStatItem(
              amnt: meditation,
              desc: "minute${meditation == 1 ? "" : "s"} of meditation"),
        ],
      ));
}
