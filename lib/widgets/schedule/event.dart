import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/screens/presenter.dart';
import 'package:provider/provider.dart';

class ScheduleEvent extends StatefulWidget {
  ScheduleEvent(this.eventItem);

  final EventItem eventItem;

  @override
  _ScheduleEventState createState() => _ScheduleEventState();
}

class _ScheduleEventState extends State<ScheduleEvent> {
  Widget _getIcon(String category, Color color) {
    switch (category) {
      case 'registration':
        {
          return Icon(
            FontAwesomeIcons.addressCard,
            color: color,
          );
        }
        break;

      case 'welcome':
        {
          return Icon(
            FontAwesomeIcons.child,
            color: color,
          );
        }
        break;

      case 'presentation':
        {
          return Icon(
            FontAwesomeIcons.microphoneAlt,
            color: color,
          );
        }
        break;

      case 'eating':
        {
          return Icon(
            FontAwesomeIcons.utensils,
            color: color,
          );
        }
        break;

      case 'award':
        {
          return Icon(
            FontAwesomeIcons.trophy,
            color: color,
          );
        }
        break;

      case 'break':
        {
          return Icon(
            FontAwesomeIcons.solidComments,
            color: color,
          );
        }
        break;

      case 'final':
        {
          return Icon(
            FontAwesomeIcons.doorOpen,
            color: color,
          );
        }
        break;

      default:
        {
          return const SizedBox();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    Color _iconsColor = Theme.of(context).accentColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        onTap: widget.eventItem.speaker == null
            ? null
            : () {
                Navigator.of(context).pushNamed(
                  Presenter.routeName,
                  arguments: {
                    'title': widget.eventItem.title,
                    'description': widget.eventItem.description,
                    'icon': _getIcon(
                      widget.eventItem.category,
                      _iconsColor,
                    ),
                    'speaker': widget.eventItem.speaker,
                  },
                );
              },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat.Hm().format(
                DateTime.parse(widget.eventItem.startDate.substring(0, 16)),
              ),
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyText1.color),
            ),
            Text(
                DateFormat.Hm().format(
                  DateTime.parse(widget.eventItem.endDate.substring(0, 16)),
                ),
                style: const TextStyle(fontSize: 12)),
          ],
        ),
        title: Text(
          widget.eventItem.title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 16,
          ),
        ),
        subtitle: widget.eventItem.speaker == null
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            width: 20,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Image.asset('assets/images/person.png'),
                            imageUrl:
                                'http:${widget.eventItem.speaker.photoFileUrl}',
                          ),
                        ),
                        Text(
                          widget.eventItem.speaker.name,
                          style: TextStyle(
                              color: _darkMode
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color
                                      .withOpacity(0.7)
                                  : Theme.of(context).primaryColor,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: _getIcon(widget.eventItem.category, _iconsColor),
            )
          ],
        ),
      ),
    );
  }
}
