import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/infoItems.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  InfoContents _currentContent = InfoContents.location;
  int _whoColorIcon = 0;

  void _changeContent(InfoContents infoContents) {
    // Anti select spam
    if (_currentContent.index == _whoColorIcon) {
      setState(() {
        _currentContent = infoContents;

        // In 500 miliseconds changing icon color
        Future<dynamic>.delayed(
          const Duration(milliseconds: 500),
        ).whenComplete(() {
          setState(() {
            _whoColorIcon = infoContents.index;
          });
        });
      });
    }
  }

  @override
  void initState() {
    Provider.of<InfoItemsProvider>(context, listen: false)
        .fetchData(
      howMany: 999,
      confId: '2019',
    )
        .catchError((Object err) {
      ConnectionSnackBar.show(
        context: context,
        message: err.toString(),
        scaffoldKeyCurrentState: _scaffoldKey.currentState,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InfoNavigation(
              currentContent: _currentContent,
              whoColorIcon: _whoColorIcon,
              changeContent: _changeContent,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    await Provider.of<InfoItemsProvider>(context, listen: false)
                        .refreshData(
                  howMany: 999,
                  confId: '2019',
                )
                        .catchError((Object err) {
                  ConnectionSnackBar.show(
                    context: context,
                    message: err.toString(),
                    scaffoldKeyCurrentState: _scaffoldKey.currentState,
                  );
                }),
                child: ListView(
                  children: [
                    InfoContent(selectedContent: _currentContent),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
