import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../services/day_collection.dart';
import '../../services/settings.dart';
import 'pages/activities/activities.dart';
import 'pages/inspiration/inspiration.dart';
import 'pages/overview/overview.dart';
import 'pages/progress/progress.dart';
import 'pages/settings/settings.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (DayCollectionService.I.dayCollection.length >= 4 &&
        !SettingsDataService.I.hasRequestedReview) {
      InAppReview.instance
          .requestReview()
          .then((_) => SettingsDataService.I.updateRequestedReview());
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: bottomNavBar,
    );
  }

  Widget get body {
    switch (tabIndex) {
      case 0:
        return ProgressTabPage();
      case 1:
        return ActivitiesTabPage();
      case 2:
        return OverviewTabPage();
      case 3:
        return InspirationTabPage();
      case 4:
        return SettingsTabPage();
    }
    throw UnimplementedError();
  }

  Widget get bottomNavBar => BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (value) => setState(() {
                HapticFeedback.selectionClick();
                tabIndex = value;
              }),
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.trip_origin), label: 'Progress'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Activities'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: 'Overview'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb), label: 'Inspiration'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ]);
}
