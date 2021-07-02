import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../components/circular_progress_view.dart';
import '../../../../../components/unfocuser.dart';
import '../../../../../services/day_collection.dart';

class ExerciseTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final minutes = useState(DayCollectionService.I.today.exercise);

    return Unfocuser(Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ExerciseForm(
              onSubmit: (_minutes) {
                DayCollectionService.I.update(exercise: _minutes);
                minutes.value = _minutes;
              },
            ),
            const SizedBox(height: 40),
            CircularProgressView(
              title: minutes.value.toString(),
              subtitle: 'minutes',
              value: minutes.value / 15,
              color: Colors.indigo,
            )
          ],
        ),
      )),
    ));
  }
}

class _ExerciseForm extends HookWidget {
  _ExerciseForm({required this.onSubmit});

  final void Function(int minutes) onSubmit;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ctrl = useTextEditingController(
        text: DayCollectionService.I.today.exercise.toString());

    final save = () {
      onSubmit(int.parse(ctrl.text));
      WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    };

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
