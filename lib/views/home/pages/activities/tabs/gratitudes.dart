import 'package:flutter/material.dart';

import '../../../../../components/gratitude_item.dart';
import '../../../../../models/day.dart';
import '../../../../../services/day_collection.dart';

class GratitudesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(children: [
          Material(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Why are you grateful today?',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w600)),
                    _GratitudesForm()
                  ],
                ),
              )),
          Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: _GratitudesList(),
          )
        ]),
      ));
}

class _GratitudesForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
                controller: _ctrl,
                decoration: InputDecoration(
                    labelText: 'I am grateful...',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        DayCollectionService.I.update(gratitudes: _ctrl.text);
                        _ctrl.clear();
                        WidgetsBinding.instance!.focusManager.primaryFocus
                            ?.unfocus();
                      },
                    )))
          ],
        ),
      );
}

class _GratitudesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: DayCollectionService.I.dayData$,
        builder: (context, AsyncSnapshot<DayModel?> snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          return Column(
              children: snapshot.data!.gratitudes
                  .map((e) => GratitudeItem(text: e))
                  .toList()
                  .cast<Widget>());
        },
      );
}
