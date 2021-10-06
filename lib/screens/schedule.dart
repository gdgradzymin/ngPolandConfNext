import 'package:flutter/material.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/shared/widgets/animatedBottomNav.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:ngPolandConf/widgets/schedule/content.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  Schedule({Key key, this.title}) : super(key: key);

  static const routeName = '/Schedule';
  final String title;
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
      drawer: const DrawerNg(
        pageName: Schedule.routeName,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => Provider.of<EventItemsProvider>(context, listen: false)
            .fetchData(howMany: 999, reload: true),
        child: ScheduleContent(),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: EventItemsProvider,
        refreshIndicatorKey: _refreshIndicatorKey,
      ),
    );
  }
}
