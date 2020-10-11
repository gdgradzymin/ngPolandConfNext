import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:provider/provider.dart';

class AnimatedBottomNav extends StatefulWidget {
  final Size deviceSize;

  AnimatedBottomNav({this.deviceSize});

  @override
  _AnimatedBottomNavState createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<AnimatedBottomNav> {
  EventItemType _selected = EventItemType.NGPOLAND;

  double _positionAnimatedColor;

  @override
  Widget build(BuildContext context) {
    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    if (_selected == EventItemType.NGPOLAND) {
      _positionAnimatedColor = 0.0;
    } else {
      _positionAnimatedColor = 0.5;
    }

    return Container(
      height: kToolbarHeight,
      decoration: const BoxDecoration(color: Colors.black),
      child: Container(
        decoration: _darkMode
            ? const BoxDecoration(
                color: Colors.white24,
              )
            : const BoxDecoration(
                color: Colors.white,
              ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              left: widget.deviceSize.width * _positionAnimatedColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: widget.deviceSize.width * 0.47,
                height: widget.deviceSize.width * 0.01,
                child: Container(
                  width: double.infinity,
                  height: widget.deviceSize.width * 0.01,
                  child: const Card(
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(255, 0, 122, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<EventItemsProvider>(context, listen: false)
                            .fetchData(
                          howMany: 999,
                          confId: '2019',
                          type: EventItemType.NGPOLAND,
                        )
                            .catchError(
                          (Object err) {
                            ConnectionSnackBar.show(
                              context: context,
                              scaffoldKeyCurrentState: null,
                            );
                          },
                        );

                        _selected = EventItemType.NGPOLAND;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ngpolandlogo.png',
                            ),
                            Text(
                              'NG POLAND',
                              textScaleFactor: 7,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: _darkMode
                                        ? _selected == EventItemType.NGPOLAND
                                            ? Theme.of(context).accentColor
                                            : Colors.white
                                        : _selected == EventItemType.NGPOLAND
                                            ? Theme.of(context).accentColor
                                            : Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<EventItemsProvider>(context, listen: false)
                            .fetchData(
                          howMany: 999,
                          confId: '2019',
                          type: EventItemType.JSPOLAND,
                        )
                            .catchError(
                          (Object err) {
                            ConnectionSnackBar.show(
                              context: context,
                              scaffoldKeyCurrentState: null,
                            );
                          },
                        );

                        _selected = EventItemType.JSPOLAND;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/jspolandlogo.png',
                            ),
                            Text(
                              'JS POLAND',
                              textScaleFactor: 7,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: _darkMode
                                        ? _selected == EventItemType.JSPOLAND
                                            ? Theme.of(context).accentColor
                                            : Colors.white
                                        : _selected == EventItemType.JSPOLAND
                                            ? Theme.of(context).accentColor
                                            : Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
