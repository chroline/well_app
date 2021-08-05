import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/max_width_container.dart';
import '../../../../components/unfocuser.dart';
import 'tabs/acts.dart';
import 'tabs/exercise.dart';
import 'tabs/gratitudes.dart';
import 'tabs/journal.dart';
import 'tabs/meditation.dart';

class ActivitiesTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActivitiesTabPage();
}

class _ActivitiesTabPage extends State {
  TextStyle get tabTextStyle => Theme.of(context)
      .textTheme
      .button!
      .copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: Unfocuser(body),
      ));

  AppBar get appBar => AppBar(
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Your Day',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700)),
        bottom: TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.3),
          indicatorColor: Colors.black.withOpacity(0.7),
          overlayColor: MaterialStateProperty.all(Colors.black12),
          tabs: [
            Tab(child: Text('GRATITUDES', style: tabTextStyle)),
            Tab(child: Text('ACTS OF KINDNESS', style: tabTextStyle)),
            Tab(child: Text('JOURNAL', style: tabTextStyle)),
            Tab(child: Text('EXERCISE', style: tabTextStyle)),
            Tab(child: Text('MEDITATION', style: tabTextStyle)),
          ],
        ),
      );

  FloatingActionButton get floatingActionButton => FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => launch(
            'https://projects.colegaw.in/well-app/help?utm_source=Well%20App&utm_medium=app&utm_campaign=well_app_activities_help'),
        child: const Icon(Icons.help_rounded),
      );

  TabBarView get body => TabBarView(
          children: [
        GratitudesTab(),
        ActsTab(),
        JournalTab(),
        ExerciseTab(),
        MeditationTab()
      ].map((e) => MaxWidthContainer(child: e)).toList());
}
