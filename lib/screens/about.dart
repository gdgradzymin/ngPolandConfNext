import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';

class About extends StatelessWidget {
  static const routeName = '/About';

  final String title;

  About({Key key, this.title}) : super(key: key);

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
              'About',
            ),
          ],
        ),
      ),
    );
  }
}
