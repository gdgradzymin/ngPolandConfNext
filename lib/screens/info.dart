import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/info/navigation.dart';

enum InfoContents {
  location,
  workshops,
  tickets,
  contact,
}

class Info extends StatefulWidget {
  static const routeName = '/Info';

  final String title;

  Info({Key key, this.title}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  InfoContents _currentContent = InfoContents.location;

  void _changeContent(InfoContents infoContents) {
    setState(() {
      _currentContent = infoContents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InfoNavigation(
                currentContent: _currentContent,
                changeContent: _changeContent,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                _currentContent.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
