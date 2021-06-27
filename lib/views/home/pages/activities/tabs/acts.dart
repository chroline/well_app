import 'package:flutter/material.dart';

import '../../../../../models/day.dart';
import '../../../../../services/day_collection.dart';

class ActsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(children: [
          Material(
              color: Colors.teal,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ActsForm(),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Divider(
              color: Colors.teal.withOpacity(0.5),
              thickness: 2,
            ),
          ),
          Text("Today's acts of kindness:",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.teal)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: _ActsList(),
          )
        ]),
      ));
}

class _ActsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                controller: _ctrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: 'Describe your act',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        DayCollectionService.I.update(acts: _ctrl.text);
                        _ctrl.clear();
                        WidgetsBinding.instance!.focusManager.primaryFocus
                            ?.unfocus();
                      },
                    ))),
          ],
        ),
      );
}

class _ActsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: DayCollectionService.I.dayData$,
        builder: (context, AsyncSnapshot<DayModel?> snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          return Column(
              children: snapshot.data!.acts
                  .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('"$e"', style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 20)
                        ],
                      ))
                  .toList()
                  .cast<Widget>());
        },
      );
}
