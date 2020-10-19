import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/screens/schedule.dart';
import 'package:ng_poland_conf_next/screens/workShops.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:provider/provider.dart';

class HomeEvents extends StatelessWidget {
  final List<Map<String, Object>> _events = [
    {
      'date': '18-11-2020',
      'name': 'NG WORKSHOPS',
      'screen': Workshops.routeName,
      'type': EventItemType.NGPOLAND,
    },
    {
      'date': '19-11-2020',
      'name': 'NG POLAND',
      'screen': Schedule.routeName,
      'type': EventItemType.NGPOLAND,
    },
    {
      'date': '20-11-2020',
      'name': 'JS POLAND',
      'screen': Schedule.routeName,
      'type': EventItemType.JSPOLAND,
    },
    {
      'date': '21-11-2020',
      'name': 'JS WORKSHOPS',
      'screen': Workshops.routeName,
      'type': EventItemType.JSPOLAND,
    },
  ];

  Widget _event(
    BuildContext context,
    String date,
    String name,
    String screen,
    EventItemType eventItemType,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.calendarAlt,
              color: Colors.white.withOpacity(0.6),
              size: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              date,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 15,
                  ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            if (screen == Workshops.routeName) {
              Provider.of<WorkshopsProvider>(context, listen: false)
                  .selectedItems = eventItemType;
            } else {
              Provider.of<EventItemsProvider>(context, listen: false)
                  .selectedItems = eventItemType;
            }

            Navigator.of(context).pushReplacementNamed(
              screen,
            );
          },
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(
            children: _events
                .map(
                  (event) => _event(
                    context,
                    event['date'] as String,
                    event['name'] as String,
                    event['screen'] as String,
                    event['type'] as EventItemType,
                  ),
                )
                .toList(),
          )
        : SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _events
                  .map(
                    (event) => _event(
                      context,
                      event['date'] as String,
                      event['name'] as String,
                      event['screen'] as String,
                      event['type'] as EventItemType,
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
