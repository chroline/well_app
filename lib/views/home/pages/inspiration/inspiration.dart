import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../components/inspiration_item.dart';
import '../../../../services/day_collection.dart';

class InspirationTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Inspiration',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 700),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _InspirationList(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ));
}

class _InspirationList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final days = DayCollectionService.I.dayCollection;

    final gratitudes = days.map((e) => e.gratitudes).expand((i) => i).toList();
    final gratitudeIndex =
        useState(gratitudes.isEmpty ? 0 : Random().nextInt(gratitudes.length));

    final acts = days.map((e) => e.acts).expand((i) => i).toList();
    final actsIndex =
        useState(acts.isEmpty ? 0 : Random().nextInt(acts.length));

    final journals =
        days.map((e) => e.journal).where((e) => e != '' && e != null).toList();
    final journalsIndex =
        useState(journals.isEmpty ? 0 : Random().nextInt(journals.length));

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InspirationItem(
            title: 'Gratitude',
            onLoadMore: () {
              gratitudeIndex.value =
                  gratitudes.isEmpty ? 0 : Random().nextInt(gratitudes.length);
            },
            child: gratitudes.isEmpty
                ? const Text('No gratitudes available',
                    style: TextStyle(fontSize: 18))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Be grateful...',
                            style: Theme.of(context).textTheme.subtitle1),
                        const SizedBox(height: 5),
                        Text(gratitudes[gratitudeIndex.value],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500))
                      ]),
          ),
          const SizedBox(height: 20),
          InspirationItem(
            title: 'Act of Kindness',
            onLoadMore: () {
              actsIndex.value =
                  acts.isEmpty ? 0 : Random().nextInt(acts.length);
            },
            child: acts.isEmpty
                ? const Text('No acts of kindness available',
                    style: TextStyle(fontSize: 18))
                : Text('"${acts[actsIndex.value]}"',
                    style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 20),
          InspirationItem(
            title: 'Journal',
            onLoadMore: () {
              journalsIndex.value =
                  journals.isEmpty ? 0 : Random().nextInt(journals.length);
            },
            child: journals.isEmpty
                ? const Text('No journals available',
                    style: TextStyle(fontSize: 18))
                : Text(journals[journalsIndex.value]!,
                    style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      ),
    );
  }
}
