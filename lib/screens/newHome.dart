import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/newHome/events.dart';
import 'package:ng_poland_conf_next/widgets/newHome/timer.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [ConnectionStatus()],
    );

    double _contentHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        kToolbarHeight;

    return Scaffold(
      appBar: appBar,
      drawer: DrawerNg(),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/tlo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black54,
            ),
            ListView(
              addRepaintBoundaries: false,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'The Biggest Angular Conference In CEE 5th Edition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 28),
                        ),
                      ),
                      SizedBox(
                        height: _contentHeight *
                            (MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 0.05
                                : 0.10),
                      ),
                      HomeTimer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Divider(
                          height: 10,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      HomeEvents(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}