import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';

class Schedule extends StatelessWidget {
  static const routeName = '/Schedule';

  final String title;

  Schedule({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
