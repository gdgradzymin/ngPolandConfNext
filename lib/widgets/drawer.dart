import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/newHome.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/widgets/switchDarkMode.dart';
import 'package:provider/provider.dart';

class DrawerNg extends StatelessWidget {
  const DrawerNg({@required this.pageName});

  final String pageName;

  @override
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

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          Column(
            children: [
              _tile(
                context: context,
                text: 'Home',
                icon: FontAwesomeIcons.gripVertical,
                routeName: Home.routeName,
                onTap: () {
                  if (pageName != Home.routeName) {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(Home.routeName),
                    );
                  }
                },
              ),
              _tile(
                context: context,
                text: 'Schedule',
                icon: FontAwesomeIcons.solidClock,
                routeName: Schedule.routeName,
                onTap: () {
                  if (pageName != Schedule.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: Schedule.routeName, route: 'left');
                    } else {
                      _pushReplacement(routeName: Schedule.routeName, route: 'left');
                    }
                  }
                },
              ),
              _tile(
                context: context,
                text: 'Workshops',
                icon: FontAwesomeIcons.solidKeyboard,
                routeName: Workshops.routeName,
                onTap: () {
                  if (pageName != Workshops.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: Workshops.routeName, route: 'left');
                    } else {
                      _pushReplacement(routeName: Workshops.routeName, route: 'left');
                    }
                  }
                },
              ),
              _tile(
                context: context,
                text: 'ngGirls',
                icon: FontAwesomeIcons.female,
                routeName: NgGirls.routeName,
                onTap: () {
                  if (pageName != NgGirls.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: NgGirls.routeName);
                    } else {
                      _pushReplacement(routeName: NgGirls.routeName);
                    }
                  }
                },
              ),
              _tile(
                context: context,
                text: 'Speakers',
                icon: FontAwesomeIcons.users,
                routeName: Speakers.routeName,
                onTap: () {
                  if (pageName != Speakers.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: Speakers.routeName);
                    } else {
                      _pushReplacement(routeName: Speakers.routeName);
                    }
                  }
                },
              ),
              _tile(
                context: context,
                text: 'Info',
                icon: FontAwesomeIcons.info,
                routeName: Info.routeName,
                onTap: () {
                  if (pageName != Info.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: Info.routeName);
                    } else {
                      _pushReplacement(routeName: Info.routeName);
                    }
                  }
                },
              ),
              _tile(
                context: context,
                text: 'About',
                icon: FontAwesomeIcons.code,
                routeName: About.routeName,
                onTap: () {
                  if (pageName != About.routeName) {
                    if (ModalRoute.of(context).settings.name == Home.routeName) {
                      _popAndPushNamed(routeName: About.routeName);
                    } else {
                      _pushReplacement(routeName: About.routeName);
                    }
                  }
                },
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

  Widget _tile({
    @required BuildContext context,
    @required String text,
    @required IconData icon,
    @required String routeName,
    @required Function() onTap,
  }) {
    Color _shadowColor = Theme.of(context).dividerColor;

    return Container(
      color: pageName == routeName ? _shadowColor : Colors.transparent,
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, ThemeNotifier theme, _) {
          Color _colorSelectedTile = pageName == routeName
              ? theme.darkTheme
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor
              : null;

          return ListTile(
            selected: pageName == routeName,
            leading: Icon(
              icon,
              color: _colorSelectedTile,
            ),
            title: Text(
              text,
              style: TextStyle(
                color: _colorSelectedTile,
              ),
            ),
            onTap: onTap,
          );
        },
      ),
    );
  }
}
