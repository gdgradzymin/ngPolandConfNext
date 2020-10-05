import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/models/pages.dart';
import 'package:ng_poland_conf_next/providers/contentful.dart';
import 'package:ng_poland_conf_next/providers/selectedPage.dart';
import 'package:ng_poland_conf_next/screens/about.dart';
import 'package:ng_poland_conf_next/screens/home.dart';
import 'package:ng_poland_conf_next/screens/info.dart';
import 'package:ng_poland_conf_next/screens/ngGirls.dart';
import 'package:ng_poland_conf_next/screens/schedule.dart';
import 'package:ng_poland_conf_next/screens/speakers.dart';
import 'package:ng_poland_conf_next/screens/workShops.dart';
import 'package:ng_poland_conf_next/widgets/switchDarkMode.dart';
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
        padding: EdgeInsets.zero,
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
                    color: selectedPage.getPage.name == PagesName.home
                        ? _shadowColor
                        : Colors.transparent,
                    child: ListTile(
                      selected: selectedPage.getPage.name == PagesName.home
                          ? true
                          : false,
                      leading: const Icon(
                        FontAwesomeIcons.gripVertical,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        selectedPage.changeSelected(name: PagesName.home);
                        Navigator.of(context).popAndPushNamed(Home.routeName);
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
                        selectedPage.changeSelected(name: PagesName.schedule);
                        Navigator.of(context)
                            .popAndPushNamed(Schedule.routeName);
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
                        selectedPage.changeSelected(name: PagesName.workshops);
                        Navigator.of(context)
                            .popAndPushNamed(WorkShops.routeName);
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
                        Provider.of<ContentfulService>(context, listen: false)
                            .getSimpleContentById(
                          myId: 'ng-girls-workshops',
                          confId: '2019',
                        );

                        selectedPage.changeSelected(name: PagesName.ngGirls);
                        Navigator.of(context)
                            .popAndPushNamed(NgGirls.routeName);
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
                        selectedPage.changeSelected(name: PagesName.speakers);
                        Navigator.of(context)
                            .popAndPushNamed(Speakers.routeName);
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
                        selectedPage.changeSelected(name: PagesName.info);
                        Navigator.of(context).popAndPushNamed(Info.routeName);
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
                  Divider(
                    thickness: 2,
                    height: 25,
                  ),
                  SwitchDarkMode(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
