import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/models/pages.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/screens/about.dart';
import 'package:ngPolandConf/screens/home.dart';
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
<<<<<<< HEAD
=======

              var getPage = selectedPage.getPage;
>>>>>>> master
              return Column(
                children: [
                  Container(
                    color: selectedPage.getPage.name == PagesName.home
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: getPage.name == PagesName.home ? true : false,
                      leading: const Icon(
                        FontAwesomeIcons.gripVertical,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.home) {
                          selectedPage.changeSelected(name: PagesName.home);
                          Navigator.of(context).popAndPushNamed(Home.routeName);
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.schedule
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.schedule
                          ? true
                          : false,
                      leading: Icon(
                        FontAwesomeIcons.solidClock,
                      ),
                      title: const Text('Schedule'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.schedule) {
                          selectedPage.changeSelected(name: PagesName.schedule);
                          Navigator.of(context).popAndPushNamed(
                            Schedule.routeName,
                            arguments: {
                              'route': 'left',
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.workshops
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.workshops
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.solidKeyboard,
                      ),
                      title: const Text('Workshops'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.workshops) {
                          selectedPage.changeSelected(
                              name: PagesName.workshops);
                          Navigator.of(context).popAndPushNamed(
                            Workshops.routeName,
                            arguments: {
                              'route': 'left',
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.ngGirls
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.ngGirls
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.female,
                        size: 30,
                      ),
                      title: const Text('ngGirls'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.ngGirls) {
                          selectedPage.changeSelected(name: PagesName.ngGirls);
                          Navigator.of(context)
                              .popAndPushNamed(NgGirls.routeName);
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.speakers
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.speakers
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.users,
                        size: 23,
                      ),
                      title: const Text('Speakers'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.speakers) {
                          selectedPage.changeSelected(name: PagesName.speakers);
                          Navigator.of(context)
                              .popAndPushNamed(Speakers.routeName);
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.info
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.info
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.info,
                      ),
                      title: const Text('Info'),
                      onTap: () {
                        if (selectedPage.getPage.name != PagesName.info) {
                          selectedPage.changeSelected(name: PagesName.info);
                          Navigator.of(context).popAndPushNamed(Info.routeName);
                        }
                      },
                    ),
                  ),
                  Container(
                    color: selectedPage.getPage.name == PagesName.about
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.about
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.code,
                      ),
                      title: const Text('About'),
                      onTap: () {
                        selectedPage.changeSelected(name: PagesName.about);
                        Navigator.of(context).popAndPushNamed(About.routeName);
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
