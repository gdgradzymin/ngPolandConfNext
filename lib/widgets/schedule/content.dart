import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/screens/presenter.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:provider/provider.dart';

class ScheduleContent extends StatefulWidget {
  ScheduleContent({this.eventItems});

  final List<EventItem> eventItems;

  @override
  _ScheduleContentState createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<ScheduleContent> {
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
    if (widget.eventItems.isEmpty) {
      Provider.of<EventItemsProvider>(context, listen: false)
          .fetchData(
        howMany: 999,
        confId: '2019',
      )
          .catchError((Object err) {
        ConnectionSnackBar.show(
          context: context,
          message: err.toString(),
        );
      });
    }
    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    Color _iconsColor = Theme.of(context).accentColor;

    return Center(
      child: widget.eventItems.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: widget.eventItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: widget.eventItems[index].speaker == null
                            ? null
                            : () {
                                Navigator.of(context).pushNamed(
                                  Presenter.routeName,
                                  arguments: {
                                    'title': widget.eventItems[index].title,
                                    'description':
                                        widget.eventItems[index].description,
                                    'icon': _getIcon(
                                      widget.eventItems[index].category,
                                      _iconsColor,
                                    ),
                                    'speaker': widget.eventItems[index].speaker,
                                  },
                                );
                              },
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat.Hm().format(
                                DateTime.parse(
                                    widget.eventItems[index].startDate),
                              ),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color),
                            ),
                            Text(
                                DateFormat.Hm().format(
                                  DateTime.parse(
                                      widget.eventItems[index].endDate),
                                ),
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        title: Text(
                          widget.eventItems[index].title,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: widget.eventItems[index].speaker == null
                            ? const Text('')
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 10,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          child: CachedNetworkImage(
                                            width: 20,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Image.asset(
                                                    'assets/images/person.png'),
                                            imageUrl:
                                                'http:${widget.eventItems[index].speaker.photoFileUrl}',
                                          ),
                                        ),
                                        Text(
                                          widget.eventItems[index].speaker.name,
                                          style: TextStyle(
                                              color: _darkMode
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .color
                                                      .withOpacity(0.7)
                                                  : Theme.of(context)
                                                      .primaryColor,
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
                              child: _getIcon(widget.eventItems[index].category,
                                  _iconsColor),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Opacity(
                          opacity: 0.9,
                          child: Divider(
                            height: 1,
                            color: _darkMode
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).accentColor,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
