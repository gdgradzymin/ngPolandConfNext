import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeEvents extends StatelessWidget {
  final List<Map<String, String>> _events = [
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
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Theme.of(context).accentColor,
                fontSize: 18,
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
