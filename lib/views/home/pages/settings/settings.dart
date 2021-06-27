import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/loading_overlay.dart';
import '../../../../components/unfocuser.dart';
import '../../../../services/notifications.dart';
import '../../../../services/settings.dart';
import '../../../../style.dart';
import '../../../../util/create_route.dart';
import '../../../../util/reset_data.dart';
import '../../../welcome/welcome.dart';

class SettingsTabPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    Future<void> reset() async {
      await showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Reset all data'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Are you sure you want to reset all data on the Well app?'),
                Text('This action is irreversible!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                isLoading.value = true;
                await resetData();
                await Navigator.of(context).pushAndRemoveUntil(
                    createFadeRoute(WelcomeView()), (r) => false);
              },
              style: TextButton.styleFrom(primary: Colors.red),
              child: const Text('RESET'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Settings',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: Unfocuser(
          Center(
            child: Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _NotificationUpdateForm(
                              onLoading: () => isLoading.value = true,
                              onComplete: () => isLoading.value = false),
                          divider,
                          OutlinedButton(
                            onPressed: reset,
                            style: OutlinedButton.styleFrom(
                                primary: Colors.red,
                                backgroundColor: Colors.white.withOpacity(0.25),
                                side: const BorderSide(
                                    width: 2.0, color: Colors.red)),
                            child: const Text('RESET DATA'),
                          ),
                        ],
                      ),
                    ),
                    Text(
                        'To learn more about the science behind the Well app,'
                        " submit feedback, and get in touch with the app's"
                        ' creator, visit the Well app homepage.',
                        style: Style.I.textTheme.caption,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () => launch('https://by.colegaw.in/well-app'),
                      child: const Text('by.colegaw.in/well-app'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get divider => const Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Divider(
          color: Colors.black26,
          height: 0,
          thickness: 2,
        ),
      );
}

class _NotificationUpdateForm extends HookWidget {
  final void Function() onLoading;
  final void Function() onComplete;

  _NotificationUpdateForm({required this.onLoading, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final notifTimeCtrl = useTextEditingController(
        text: SettingsDataService.I.scheduledNotifTime.format(context));

    Future<void> updateNotifTime() async {
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: SettingsDataService.I.scheduledNotifTime);
      if (timeOfDay != null) {
        onLoading();
        await NotificationService.I.scheduleNotifs(timeOfDay);
        notifTimeCtrl.text =
            SettingsDataService.I.scheduledNotifTime.format(context);
        onComplete();
      }
    }

    return TextField(
      controller: notifTimeCtrl,
      readOnly: true,
      onTap: updateNotifTime,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Notification time',
        suffixIcon: IconButton(
          onPressed: updateNotifTime,
          icon: const Icon(Icons.schedule),
        ),
      ),
    );
  }
}
