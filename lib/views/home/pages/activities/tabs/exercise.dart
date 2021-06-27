import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../components/circular_progress_view.dart';
import '../../../../../components/unfocuser.dart';
import '../../../../../models/day.dart';
import '../../../../../services/day_collection.dart';

class ExerciseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Unfocuser(Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ExerciseForm(),
              const SizedBox(height: 40),
              progressView
            ],
          ),
        )),
      ));

  Widget get progressView => StreamBuilder(
      stream: DayCollectionService.I.dayData$,
      builder: (context, AsyncSnapshot<DayModel?> snapshot) =>
          CircularProgressView(
            title: snapshot.hasData ? snapshot.data!.exercise.toString() : '0',
            subtitle: 'minutes',
            value: (snapshot.hasData ? snapshot.data!.exercise : 0) / 20,
            color: Colors.indigo,
          ));
}

class _ExerciseForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ctrl = useTextEditingController(
        text: DayCollectionService.I.dayData$.valueWrapper!.value!.exercise
            .toString());

    void save() {
      DayCollectionService.I.update(exercise: int.parse(ctrl.value.text));
      WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    }

    return Form(
      key: _formKey,
      child: Row(
        children: [
          const Icon(Icons.timer),
          const SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              controller: ctrl,
              onEditingComplete: save,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Minutes of exercise',
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: save,
                  icon: const Icon(Icons.save),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
