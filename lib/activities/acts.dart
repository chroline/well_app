import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:well_app_core/well_app_core.dart';

class ActsTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final acts = useState(DayCollectionStore.today.acts.toList());

    return SingleChildScrollView(
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
                  _ActsForm(
                    onSubmit: (text) {
                      DayCollectionRepository.update(acts: text);
                      final _acts = acts.value.toList()..insert(0, text);
                      acts.value = _acts;
                    },
                  ),
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
          child: _ActsList(acts: acts.value),
        )
      ]),
    ));
  }
}

class _ActsForm extends StatelessWidget {
  _ActsForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String text) onSubmit;

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
                        onSubmit(_ctrl.text);
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
  const _ActsList({Key? key, required this.acts}) : super(key: key);

  final List<String> acts;

  @override
  Widget build(BuildContext context) => Column(
      children: acts
          .map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('"$e"', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20)
                ],
              ))
          .toList()
          .cast<Widget>());
}
