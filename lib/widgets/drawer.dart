import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/models/pages.dart';
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
              double _animationTop = selectedPage.getPage.number *
                  MediaQuery.of(context).size.height *
                  0.07;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    top: _animationTop,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.75,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        ListTile(
                          selected: selectedPage.getPage.name == PagesName.home
                              ? true
                              : false,
                          leading: Icon(
                            FontAwesomeIcons.gripVertical,
                          ),
                          title: Text('Home'),
                          onTap: () {
                            selectedPage.changeSelected(name: PagesName.home);
                            Navigator.of(context)
                                .popAndPushNamed(Home.routeName);
                          },
                        ),
                        ListTile(
                          selected:
                              selectedPage.getPage.name == PagesName.schedule
                                  ? true
                                  : false,
                          leading: Icon(
                            FontAwesomeIcons.solidClock,
                          ),
                          title: Text('Schedule'),
                          onTap: () {
                            selectedPage.changeSelected(
                                name: PagesName.schedule);
                            Navigator.of(context)
                                .popAndPushNamed(Schedule.routeName);
                          },
                        ),
                        ListTile(
                          selected:
                              selectedPage.getPage.name == PagesName.workshops
                                  ? true
                                  : false,
                          leading: Icon(
                            FontAwesomeIcons.solidKeyboard,
                          ),
                          title: Text('Workshops'),
                          onTap: () {
                            selectedPage.changeSelected(
                                name: PagesName.workshops);
                            Navigator.of(context)
                                .popAndPushNamed(WorkShops.routeName);
                          },
                        ),
                        ListTile(
                          selected:
                              selectedPage.getPage.name == PagesName.ngGirls
                                  ? true
                                  : false,
                          leading: Icon(
                            FontAwesomeIcons.female,
                            size: 30,
                          ),
                          title: Text('ngGirls'),
                          onTap: () {
                            selectedPage.changeSelected(
                                name: PagesName.ngGirls);
                            Navigator.of(context)
                                .popAndPushNamed(NgGirls.routeName);
                          },
                        ),
                        ListTile(
                          selected:
                              selectedPage.getPage.name == PagesName.speakers
                                  ? true
                                  : false,
                          leading: Icon(
                            FontAwesomeIcons.users,
                            size: 23,
                          ),
                          title: Text('Speakers'),
                          onTap: () {
                            selectedPage.changeSelected(
                                name: PagesName.speakers);
                            Navigator.of(context)
                                .popAndPushNamed(Speakers.routeName);
                          },
                        ),
                        ListTile(
                          selected: selectedPage.getPage.name == PagesName.info
                              ? true
                              : false,
                          leading: Icon(
                            FontAwesomeIcons.info,
                          ),
                          title: Text('Info'),
                          onTap: () {
                            selectedPage.changeSelected(name: PagesName.info);
                            Navigator.of(context)
                                .popAndPushNamed(Info.routeName);
                          },
                        ),
                        ListTile(
                          selected: selectedPage.getPage.name == PagesName.about
                              ? true
                              : false,
                          leading: Icon(
                            FontAwesomeIcons.code,
                          ),
                          title: Text('About'),
                          onTap: () {
                            selectedPage.changeSelected(name: PagesName.about);
                            Navigator.of(context)
                                .popAndPushNamed(About.routeName);
                          },
                        ),
                        Divider(
                          thickness: 2,
                          height: 25,
                        ),
                        SwitchDarkMode(),
                      ],
                    ),
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
