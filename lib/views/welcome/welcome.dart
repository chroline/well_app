import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/loading_overlay.dart';
import '../../components/max_width_container.dart';
import '../../services/notifications.dart';
import '../../services/settings.dart';
import '../../style.dart';
import '../../util/create_route.dart';
import '../home/home.dart';

class WelcomeView extends HookWidget {
  Future<void> initApp() async {
    await SettingsDataService.I.updateInitialSession();

    if (!kIsWeb) {
      await NotificationService.I.requestPermissions();
      await NotificationService.I
          .scheduleNotifs(const TimeOfDay(hour: 19, minute: 0));
    }
    SettingsDataService.I.scheduledNotifTime =
        const TimeOfDay(hour: 19, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading.value,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Style.I.theme.backgroundColor,
          child: Center(
            child: MaxWidthContainer(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          header,
                          ElevatedButton(
                            onPressed: () async {
                              isLoading.value = true;
                              await initApp();
                              await Navigator.of(context).pushAndRemoveUntil(
                                  createFadeRoute(HomeView()), (r) => false);
                            },
                            child: const Text(
                              'GET STARTED',
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.25),
                                side: const BorderSide(
                                    width: 2.0, color: Colors.indigo)),
                            onPressed: () => launch(
                                'https://projects.colegaw.in/well-app?utm_source=Well%20App&utm_medium=app&utm_campaign=well_app_more_information'),
                            child: const Text('MORE INFORMATION',
                                style: TextStyle(color: Colors.indigo)),
                          )
                        ],
                      ),
                    ),
                    footer
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get header => Column(
        children: [
          const Text(
            'Well',
            style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 96, height: 1),
          ),
          const SizedBox(height: 10),
          Text(
            'Improve your productivity and long-term happiness in just 21 days.'
            ' Backed by studies from leading doctors and psychologists.',
            style: Style.I.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      );

  Widget get footer => Column(
        children: [
          Text(
            'CREATED BY COLE GAWIN, 2021',
            style: Style.I.theme.textTheme.overline,
            textAlign: TextAlign.center,
          )
        ],
      );
}
