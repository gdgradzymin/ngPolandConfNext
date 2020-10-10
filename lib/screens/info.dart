import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/infoItems.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/info/content.dart';
import 'package:ng_poland_conf_next/widgets/info/navigation.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    Provider.of<InfoItemsProvider>(context, listen: false).fetchData(
      howMany: 999,
      confId: '2019',
      refresh: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<InfoItemsProvider>(context, listen: false).fetchData(
          howMany: 999,
          confId: '2019',
          refresh: true,
        ),
        child: SingleChildScrollView(
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
                InfoContent(selectedContent: _currentContent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
