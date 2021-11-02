import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/models/conferences.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/screens/schedule.dart';
import 'package:ngPolandConf/screens/workShops.dart';
import 'package:ngPolandConf/services/contentful.dart';
import 'package:provider/provider.dart';

class HomeEvents extends StatelessWidget {
  HomeEvents({this.conferencesData});

  final Conferences conferencesData;

  final List<Map<String, Object>> _events = [];

  Widget _event(
    BuildContext context,
    String date,
    String name,
    String screen,
    EventItemType eventItemType,
    String pageName,
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
                    color: Colors.white.withOpacity(0.65),
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
            if (pageName == Workshops.routeName) {
              Provider.of<SelectedPage>(context, listen: false).changeSelected(
                name: Workshops.routeName,
              );
            } else if (pageName == Schedule.routeName) {
              Provider.of<SelectedPage>(context, listen: false).changeSelected(
                name: Schedule.routeName,
              );
            }

            if (screen == Workshops.routeName) {
              Provider.of<WorkshopsProvider>(context, listen: false).selectedItems = eventItemType;
            } else {
              Provider.of<EventItemsProvider>(context, listen: false).selectedItems = eventItemType;
            }

            Navigator.of(context).pushNamed(screen, arguments: {
              'route': 'scale',
            });
          },
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.95),
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
    if (_events.isEmpty && conferencesData?.listItems != null)
      for (final ConferenceHomePageScheduleItem element in conferencesData.listItems)
        switch (element.name.toLowerCase()) {
          case 'ng workshops':
            _events.add(
              {
                'date': element.desc,
                'name': element.name,
                'screen': Workshops.routeName,
                'type': EventItemType.NGPOLAND,
                'pageName': Workshops.routeName,
              },
            );
            break;
          case 'ng poland':
            _events.add(
              {
                'date': element.desc,
                'name': element.name,
                'screen': Schedule.routeName,
                'type': EventItemType.NGPOLAND,
                'pageName': Schedule.routeName,
              },
            );
            break;
          case 'js poland':
            _events.add(
              {
                'date': element.desc,
                'name': element.name,
                'screen': Schedule.routeName,
                'type': EventItemType.JSPOLAND,
                'pageName': Schedule.routeName,
              },
            );
            break;
          case 'js workshops':
            _events.add(
              {
                'date': element.desc,
                'name': element.name,
                'screen': Workshops.routeName,
                'type': EventItemType.JSPOLAND,
                'pageName': Workshops.routeName,
              },
            );
            break;
        }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _events.isEmpty ? 0 : 1,
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
              children: _events
                  .map(
                    (event) => _event(
                      context,
                      event['date'] as String,
                      event['name'] as String,
                      event['screen'] as String,
                      event['type'] as EventItemType,
                      event['pageName'] as String,
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
                        event['pageName'] as String,
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
