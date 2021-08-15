import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:well_app_core/well_app_core.dart';

import 'home/home.dart';
import 'loading/loading.dart';
import 'style.dart';
import 'welcome/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(WellApp());
}

class WellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Style.init(context: context);
    try {
      GetIt.I<Style>();
    } catch (_) {
      GetIt.I.registerSingleton(style);
    }

    return MaterialApp(
        title: 'The Well App',
        theme: style.theme,
        home: FutureBuilder(
          future: () async {
            await Hive.initFlutter();
            Hive.registerAdapter(DayModelAdapter());

            await SettingsDataRepository.init();
            await NotificationRepository.init();
            await DayCollectionRepository.init();

            return true;
          }(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Material(
                child: SettingsDataStore.isInitialSession
                    ? WelcomeView()
                    : HomeView(),
              );
            } else {
              return LoadingView();
            }
          },
        ));
  }
}
