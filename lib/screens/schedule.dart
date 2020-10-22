import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:ngPolandConf/shared/widgets/animatedBottomNav.dart';
import 'package:ngPolandConf/widgets/schedule/content.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  static const routeName = '/Schedule';

  final String title;

  const Schedule({Key key, this.title}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<EventItem> _eventItems =
        Provider.of<EventItemsProvider>(context).eventItems;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<EventItemsProvider>(context, listen: false)
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
        child: ScheduleContent(eventItems: _eventItems),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: EventItemsProvider,
      ),
    );
  }
}
