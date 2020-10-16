import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeEvents extends StatelessWidget {
  List<Map<String, String>> _events = [
    {
      'date': '18-11-2020',
      'name': 'NG WORKSHOPS',
    },
    {
      'date': '19-11-2020',
      'name': 'NG POLAND',
    },
    {
      'date': '20-11-2020',
      'name': 'JS POLANDS',
    },
    {
      'date': '21-11-2020',
      'name': 'JS WORKSHOPS',
    },
  ];

  Widget _event(BuildContext context, String date, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.calendarCheck,
          color: Colors.grey[700],
          size: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          date,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.grey,
                fontSize: 15,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Theme.of(context).accentColor,
                fontSize: 17,
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
                    event['date'],
                    event['name'],
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
                      event['date'],
                      event['name'],
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
