import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/models/pages.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/widgets/home/button.dart';

class HomeTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      children: <Widget>[
        HomeButton(
          name: 'Schedule',
          icon: FontAwesomeIcons.solidClock,
          selectedPage: PagesName.schedule,
          routeName: Schedule.routeName,
        ),
        HomeButton(
          name: '  Workshops',
          icon: FontAwesomeIcons.solidKeyboard,
          selectedPage: PagesName.workshops,
          routeName: Workshops.routeName,
        ),
        HomeButton(
          name: 'ngGirls',
          icon: FontAwesomeIcons.female,
          selectedPage: PagesName.ngGirls,
          routeName: NgGirls.routeName,
        ),
        HomeButton(
          name: '   Speakers',
          icon: FontAwesomeIcons.users,
          selectedPage: PagesName.speakers,
          routeName: Speakers.routeName,
        ),
        HomeButton(
          name: 'Info',
          icon: FontAwesomeIcons.info,
          selectedPage: PagesName.info,
          routeName: Info.routeName,
        ),
        HomeButton(
          name: '    About',
          icon: FontAwesomeIcons.code,
          selectedPage: PagesName.about,
          routeName: About.routeName,
        ),
      ],
    );
  }
}
