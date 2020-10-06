import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/screens/about.dart';
import 'package:ng_poland_conf_next/screens/info.dart';
import 'package:ng_poland_conf_next/screens/ngGirls.dart';
import 'package:ng_poland_conf_next/screens/schedule.dart';
import 'package:ng_poland_conf_next/screens/speakers.dart';
import 'package:ng_poland_conf_next/screens/workShops.dart';
import 'package:ng_poland_conf_next/widgets/home/button.dart';

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
          routeName: Schedule.routeName,
        ),
        HomeButton(
          name: 'Workshops',
          icon: FontAwesomeIcons.solidKeyboard,
          routeName: WorkShops.routeName,
        ),
        HomeButton(
          name: 'ngGirls',
          icon: FontAwesomeIcons.female,
          routeName: NgGirls.routeName,
        ),
        HomeButton(
          name: 'Speakers',
          icon: FontAwesomeIcons.users,
          routeName: Speakers.routeName,
        ),
        HomeButton(
          name: 'Info',
          icon: FontAwesomeIcons.info,
          routeName: Info.routeName,
        ),
        HomeButton(
          name: 'About',
          icon: FontAwesomeIcons.code,
          routeName: About.routeName,
        ),
      ],
    );
  }
}