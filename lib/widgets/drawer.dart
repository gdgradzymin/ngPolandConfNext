import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/models/pages.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/newHome.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/screens/ngGirls.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/speakers.dart';
import 'package:ngPolandConf/screens/workshops.dart';
import 'package:ngPolandConf/widgets/switchDarkMode.dart';
import 'package:provider/provider.dart';

class DrawerNg extends StatefulWidget {
  @override
  _DrawerNgState createState() => _DrawerNgState();
}

class _DrawerNgState extends State<DrawerNg> {
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
      Provider.of<SelectedPage>(context, listen: false)
          .changeSelected(name: routeName);
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
      Provider.of<SelectedPage>(context, listen: false)
          .changeSelected(name: routeName);
    }

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          Consumer<SelectedPage>(
            builder: (context, selectedPage, _) {
              Color _shadowColor = Theme.of(context).dividerColor;
              return Column(
                children: [
                  Container(
                    color: selectedPage.getPage.name == Home.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == Home.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.gripVertical,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        if (selectedPage.getPage.name != Home.routeName) {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Home.routeName),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == Schedule.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == Schedule.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.solidClock,
                      ),
                      title: const Text('Schedule'),
                      onTap: () {
                        if (selectedPage.getPage.name != Schedule.routeName) {
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
                    color: selectedPage.getPage.name == Workshops.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected:
                          selectedPage.getPage.name == Workshops.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.solidKeyboard,
                      ),
                      title: const Text('Workshops'),
                      onTap: () {
                        if (selectedPage.getPage.name != Workshops.routeName) {
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
                    color: selectedPage.getPage.name == NgGirls.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == NgGirls.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.female,
                        size: 30,
                      ),
                      title: const Text('ngGirls'),
                      onTap: () {
                        if (selectedPage.getPage.name != NgGirls.routeName) {
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
                    color: selectedPage.getPage.name == Speakers.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == Speakers.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.users,
                        size: 23,
                      ),
                      title: const Text('Speakers'),
                      onTap: () {
                        if (selectedPage.getPage.name != Speakers.routeName) {
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
                    color: selectedPage.getPage.name == Info.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == Info.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.info,
                      ),
                      title: const Text('Info'),
                      onTap: () {
                        if (selectedPage.getPage.name != Info.routeName) {
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
                    color: selectedPage.getPage.name == About.routeName
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == About.routeName,
                      leading: const Icon(
                        FontAwesomeIcons.code,
                      ),
                      title: const Text('About'),
                      onTap: () {
                        if (selectedPage.getPage.name != About.routeName) {
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
              );
            },
          ),
        ],
      ),
    );
  }
}
