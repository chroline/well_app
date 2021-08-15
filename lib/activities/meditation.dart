import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:well_app_core/well_app_core.dart';

class MeditationTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final minutes = useState(DayCollectionStore.today.meditation);

    return Unfocuser(Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MeditationForm(
              onSubmit: (_minutes) {
                DayCollectionRepository.update(meditation: _minutes);
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

class _MeditationForm extends HookWidget {
  _MeditationForm({required this.onSubmit});

  final void Function(int minutes) onSubmit;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ctrl = useTextEditingController(
        text: DayCollectionStore.today.meditation.toString());

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
                labelText: 'Minutes of meditation',
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
