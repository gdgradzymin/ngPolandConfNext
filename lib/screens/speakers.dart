import 'package:flutter/material.dart';
import 'package:ngPolandConf/providers/speakers.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:ngPolandConf/widgets/speakers/content.dart';
import 'package:provider/provider.dart';

class Speakers extends StatelessWidget {
  static const routeName = '/Speakers';

  final String title;

  Speakers({Key key, this.title}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => Provider.of<SpeakersProvider>(context, listen: false)
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
        child: Center(
          child: SpeakersContent(
            _refreshIndicatorKey,
          ),
        ),
      ),
    );
  }
}
