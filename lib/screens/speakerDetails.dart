import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:provider/provider.dart';

class SpeakerDetails extends StatelessWidget {
  static const routeName = '/SpeakerDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'speakerName', // speaker.name
          style: TextStyle(
            color: Provider.of<ThemeNotifier>(context).darkTheme
                ? Theme.of(context).accentColor
                : Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/images/person.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'speakerRole', // speaker.role
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('speakerBio'), // speaker.bio
            ),
          ],
        ),
      ),
    );
  }
}
