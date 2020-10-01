import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerNg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
          Container(
            color: Colors.grey[200],
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.gripVertical,
                color: Colors.black,
              ),
              title: Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.solidClock,
              color: Colors.black,
            ),
            title: Text('Schedule'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.solidKeyboard,
              color: Colors.black,
            ),
            title: Text('Workshops'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.female,
              color: Colors.black,
              size: 30,
            ),
            title: Text('ngGirls'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.users,
              color: Colors.black,
              size: 23,
            ),
            title: Text('Speakers'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.info,
              color: Colors.black,
            ),
            title: Text('Info'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.code,
              color: Colors.black,
            ),
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
