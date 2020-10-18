import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/schedule/animatedBottomNav.dart';
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
  void initState() {
    Provider.of<EventItemsProvider>(context, listen: false)
        .fetchData(
      howMany: 999,
      confId: '2019',
      type: EventItemType.NGPOLAND,
    )
        .catchError((Object err) {
      ConnectionSnackBar.show(
        context: context,
        message: err.toString(),
        scaffoldKeyCurrentState: _scaffoldKey.currentState,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EventItem> _eventItems =
        Provider.of<EventItemsProvider>(context).eventItems;

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    Color _iconsColor = Theme.of(context).accentColor;

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
        child: Center(
          child: _eventItems.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _eventItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: _eventItems[index].speaker == null
                                ? null
                                : () {
                                    Navigator.of(context).pushNamed(
                                      '/Presenter',
                                      arguments: {
                                        'title': _eventItems[index].title,
                                        'description':
                                            _eventItems[index].description,
                                        'icon': _getIcon(
                                          _eventItems[index].category,
                                          _iconsColor,
                                        ),
                                        'speaker': _eventItems[index].speaker,
                                      },
                                    );
                                  },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat.Hm().format(
                                    DateTime.parse(
                                        _eventItems[index].startDate),
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
                                          _eventItems[index].endDate),
                                    ),
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            title: Text(
                              _eventItems[index].title,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: _eventItems[index].speaker == null
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          spacing: 10,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              child: CachedNetworkImage(
                                                width: 20,
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    Image.asset(
                                                        'assets/images/person.png'),
                                                imageUrl:
                                                    'http:${_eventItems[index].speaker.photoFileUrl}',
                                              ),
                                            ),
                                            Text(
                                              _eventItems[index].speaker.name,
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
                                  child: _getIcon(
                                      _eventItems[index].category, _iconsColor),
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
        ),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: EventItemsProvider,
      ),
    );
  }
}
