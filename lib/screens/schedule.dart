import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/schedule/animatedBottomNav.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  static const routeName = '/Schedule';

  final String title;

  Schedule({Key key, this.title}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool _fetchdata = false;

  @override
  void didChangeDependencies() {
    if (!_fetchdata) {
      Provider.of<EventItemsProvider>(context, listen: false).fetchData(
        howMany: 999,
        confId: '2019',
        type: EventItemType.NGPOLAND,
      );
      _fetchdata = true;
    }

    super.didChangeDependencies();
  }

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
    List<EventItem> _eventItems =
        Provider.of<EventItemsProvider>(context).eventItems;

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    Color _iconsColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<EventItemsProvider>(context, listen: false).refreshData(
          howMany: 999,
          confId: '2019',
        ),
        child: Ink(
          decoration: _darkMode
              ? const BoxDecoration()
              : BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.grey[500],
                      Colors.grey[400],
                      Colors.grey[400],
                      Colors.grey[400],
                    ],
                  ),
                ),
          child: Center(
            child: ListView.builder(
              itemCount: _eventItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: _darkMode
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Colors.grey[500],
                                Colors.grey[400],
                                Colors.grey[400],
                                Colors.grey[400],
                              ],
                            ),
                          )
                        : const BoxDecoration(color: Colors.white),
                    child: ListTile(
                      onTap: _eventItems[index].speaker == null
                          ? null
                          : () {
                              Navigator.of(context).pushNamed(
                                '/SchedulePresenter',
                                arguments: {
                                  'title': _eventItems[index].title,
                                  'description': _eventItems[index].description,
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
                              DateTime.parse(_eventItems[index].startDate),
                            ),
                          ),
                          Text(
                            DateFormat.Hm().format(
                              DateTime.parse(_eventItems[index].endDate),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        _eventItems[index].title,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      subtitle: _eventItems[index].speaker == null
                          ? const Text('')
                          : Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      child: Image.network(
                                        'http:${_eventItems[index].speaker.photoFileUrl}',
                                        width: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text(_eventItems[index].speaker.name),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                              ],
                            ),
                      trailing:
                          _getIcon(_eventItems[index].category, _iconsColor),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
      ),
    );
  }
}
