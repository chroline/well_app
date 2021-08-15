import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:well_app_core/well_app_core.dart';

import 'progress_item.dart';

class ProgressTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DayCollectionStore.today;

    final completed = calculateDayCompletion(today);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Theme.of(context).backgroundColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Today's progress",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w700)),
            ),
            pinned: true,
            forceElevated: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 700),
                  child: Column(
                    children: [
                      const SizedBox(height: 75),
                      CircularProgressView(
                        title: (completed * 100).toStringAsFixed(0) + '%',
                        subtitle: 'completed',
                        value: completed,
                        color: Colors.teal,
                      ),
                      const SizedBox(height: 75),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ProgressItem(
                                title: 'Record 3 gratitudes',
                                value: today.gratitudes.length / 3),
                            ProgressItem(
                                title: 'Perform 3 acts of kindness',
                                value: today.acts.length / 3),
                            ProgressItem(
                                title: 'Write an entry in the Journal',
                                value:
                                    today.journal != null && today.journal != ''
                                        ? 1
                                        : 0),
                            ProgressItem(
                                title: 'Exercise for 20 minutes',
                                value: today.exercise / 20),
                            ProgressItem(
                                title: 'Meditate for 15 minutes',
                                value: today.meditation / 15),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
