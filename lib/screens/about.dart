import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/authors.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  About({Key key, this.title}) : super(key: key);

  static const routeName = '/About';
  final String title;

  final List<Author> _dataAuthors = [
    Author(
      name: 'Daniel Michalak',
      image: 'danielmichalak',
      twitterUrl: 'https://twitter.com/MichalakDaniel2',
    ),
    Author(
      name: 'Sebastian Denis',
      image: 'sebastiandenis',
      twitterUrl: 'https://twitter.com/SebekD',
    ),
    Author(
      name: 'Dariusz Kalbarczyk',
      image: 'dariuszkalbarczyk',
      twitterUrl: 'https://twitter.com/ngKalbarczyk',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: const DrawerNg(
        pageName: About.routeName,
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset('assets/images/logo.png'),
              ),
              const Text(
                'This app is built with Flutter!',
              ),
              Divider(
                color: Theme.of(context).dividerTheme.color,
                height: 35,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Authors:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                children: _dataAuthors
                    .map(
                      (author) => Column(
                        children: [
                          ListTile(
                            onTap: () => launch(author.twitterUrl),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/images/authors/${author.image}.jpg',
                                height: 50,
                              ),
                            ),
                            title: Text(author.name),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Divider(
                color: Theme.of(context).dividerTheme.color,
                height: 35,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/github.png',
                  height: 50,
                ),
                title: InkWell(
                  onTap: () =>
                      launch('https://github.com/gdgradzymin/ngPolandConfNext'),
                  child: const Text(
                    'ngPolandConfNext',
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
