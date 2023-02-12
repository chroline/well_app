import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:well_app_core/well_app_core.dart';

import '../activities/activities.dart';
import '../inspiration/inspiration.dart';
import '../overview/overview.dart';
import '../progress/progress.dart';
import '../settings/settings.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (DayCollectionStore.dayCollection.length >= 4 &&
        !SettingsDataStore.hasRequestedReview) {
      _requestReview();
    }

    return Scaffold(
      body: _body,
      bottomNavigationBar: _bottomNavBar,
    );
  }

  Widget get _body => IndexedStack(
        index: _tabIndex,
        children: <Widget>[
          ProgressTabPage(),
          ActivitiesTabPage(),
          OverviewTabPage(),
          InspirationTabPage(),
          SettingsTabPage(),
        ],
      );

  Widget get _bottomNavBar => BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (value) {
          HapticFeedback.selectionClick();
          setState(() => _tabIndex = value);
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin),
            label: 'Progress',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Activities',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Overview',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Inspiration',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      );

  void _requestReview() async {
    await InAppReview.instance.requestReview();
    await SettingsDataService.updateRequestedReview();
  }
}
