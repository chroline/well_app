import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../components/gratitude_item.dart';
import '../../../../../services/day_collection.dart';

class GratitudesTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gratitudes =
        useState(DayCollectionService.I.today.gratitudes.toList());

    return SingleChildScrollView(
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
                  _GratitudesForm(
                    onSubmit: (String text) {
                      DayCollectionService.I.update(gratitudes: text);
                      final _gratitudes = gratitudes.value.toList()
                        ..insert(0, text);
                      gratitudes.value = _gratitudes;
                    },
                  )
                ],
              ),
            )),
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: _GratitudesList(
            gratitudes: gratitudes.value,
          ),
        )
      ]),
    ));
  }
}

class _GratitudesForm extends StatelessWidget {
  _GratitudesForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String text) onSubmit;

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
                        onSubmit(_ctrl.text);
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
  const _GratitudesList({Key? key, required this.gratitudes}) : super(key: key);

  final List<String> gratitudes;

  @override
  Widget build(BuildContext context) => Column(
      children: gratitudes
          .map((e) => GratitudeItem(text: e))
          .toList()
          .cast<Widget>());
}
