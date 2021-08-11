import 'package:flutter/material.dart';

import '../../../../../services/day_collection.dart';

class JournalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: _JournalForm(),
        ),
      ));
}

class _JournalForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JournalFormState();
}

class _JournalFormState extends State<_JournalForm> {
  final _formKey = GlobalKey<FormState>();

  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl.text = (DayCollectionService.I.today.journal ?? '').toString();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                controller: _ctrl,
                minLines: 12,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Write your journal here',
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  DayCollectionService.I.update(journal: _ctrl.text);
                  WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
                },
                child: const Text('SAVE JOURNAL'),
              ),
            )
          ],
        ),
      );
}
