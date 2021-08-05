import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/day.dart';
import 'services/day_collection.dart';
import 'services/notifications.dart';
import 'services/settings.dart';
import 'style.dart';
import 'views/home/home.dart';
import 'views/welcome/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DayModelAdapter());

  final settingsDataService = await SettingsDataService.init();
  GetIt.I.registerSingleton(settingsDataService);

  final notificationService = await NotificationService.init();
  GetIt.I.registerSingleton(notificationService);

  final dayCollectionService = await DayCollectionService.init();
  GetIt.I.registerSingleton(dayCollectionService);

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
        home: Material(
          child: SettingsDataService.I.isInitialSession
              ? WelcomeView()
              : HomeView(),
        ));
  }
}
