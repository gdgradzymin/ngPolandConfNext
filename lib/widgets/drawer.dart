import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/newHome.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/widgets/switchDarkMode.dart';

class DrawerNg extends StatelessWidget {
  const DrawerNg({@required this.pageName});

  final String pageName;

  Widget build(BuildContext context) {
    void _popAndPushNamed({
      @required String routeName,
      String route = '',
    }) {
      Navigator.of(context).popAndPushNamed(
        routeName,
        arguments: {
          'route': route,
        },
      );
    }

    void _pushReplacement({
      @required String routeName,
      String route = '',
    }) {
      Navigator.of(context).pushReplacementNamed(
        routeName,
        arguments: {
          'route': route,
        },
      );
    }

    Color _shadowColor = Theme.of(context).dividerColor;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          Column(
            children: [
              Container(
                color: pageName == Home.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == Home.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.gripVertical,
                  ),
                  title: const Text('Home'),
                  onTap: () {
                    if (pageName != Home.routeName) {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(Home.routeName),
                      );
                    }
                  },
                ),
              ),
              Container(
                color: pageName == Schedule.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == Schedule.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.solidClock,
                  ),
                  title: const Text('Schedule'),
                  onTap: () {
                    if (pageName != Schedule.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(
                            routeName: Schedule.routeName, route: 'left');
                      } else {
                        _pushReplacement(
                            routeName: Schedule.routeName, route: 'left');
                      }
                    }
                  },
                ),
              ),
              Container(
                color: pageName == Workshops.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == Workshops.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.solidKeyboard,
                  ),
                  title: const Text('Workshops'),
                  onTap: () {
                    if (pageName != Workshops.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(
                            routeName: Workshops.routeName, route: 'left');
                      } else {
                        _pushReplacement(
                            routeName: Workshops.routeName, route: 'left');
                      }
                    }
                  },
                ),
              ),
              Container(
                color: pageName == NgGirls.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == NgGirls.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.female,
                    size: 30,
                  ),
                  title: const Text('ngGirls'),
                  onTap: () {
                    if (pageName != NgGirls.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(routeName: NgGirls.routeName);
                      } else {
                        _pushReplacement(routeName: NgGirls.routeName);
                      }
                    }
                  },
                ),
              ),
              Container(
                color: pageName == Speakers.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == Speakers.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.users,
                    size: 23,
                  ),
                  title: const Text('Speakers'),
                  onTap: () {
                    if (pageName != Speakers.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(routeName: Speakers.routeName);
                      } else {
                        _pushReplacement(routeName: Speakers.routeName);
                      }
                    }
                  },
                ),
              ),
              Container(
                color: pageName == Info.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == Info.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.info,
                  ),
                  title: const Text('Info'),
                  onTap: () {
                    if (pageName != Info.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(routeName: Info.routeName);
                      } else {
                        _pushReplacement(routeName: Info.routeName);
                      }
                    }
                  },
                ),
              ),
              Container(
                color: pageName == About.routeName
                    ? _shadowColor
                    : Colors.transparent,
                child: ListTile(
                  selected: pageName == About.routeName,
                  leading: const Icon(
                    FontAwesomeIcons.code,
                  ),
                  title: const Text('About'),
                  onTap: () {
                    if (pageName != About.routeName) {
                      if (ModalRoute.of(context).settings.name ==
                          Home.routeName) {
                        _popAndPushNamed(routeName: About.routeName);
                      } else {
                        _pushReplacement(routeName: About.routeName);
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  height: 25,
                  color: Theme.of(context).dividerTheme.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                child: SwitchDarkMode(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
