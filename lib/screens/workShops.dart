import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/shared/widgets/animatedBottomNav.dart';
import 'package:ng_poland_conf_next/widgets/workshops/content.dart';
import 'package:provider/provider.dart';

class Workshops extends StatefulWidget {
  static const routeName = '/Workshops';

  final String title;

  Workshops({Key key, this.title}) : super(key: key);

  @override
  _WorkshopsState createState() => _WorkshopsState();
}

class _WorkshopsState extends State<Workshops> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Workshop> _workshopsItems =
        Provider.of<WorkshopsProvider>(context).workshopItems;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<WorkshopsProvider>(context, listen: false)
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
        child: WorkshopsContent(workshopsItems: _workshopsItems),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: WorkshopsProvider,
      ),
    );
  }
}
