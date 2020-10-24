import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/eventItems.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/schedule/event.dart';
import 'package:provider/provider.dart';

class ScheduleContent extends StatefulWidget {
  const ScheduleContent({
    this.refreshIndicatorKey,
  });

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  _ScheduleContentState createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<ScheduleContent> {
  Timer _timer;

  bool _animation = false;

  bool _loadingData = false;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) => setState(() {
        _animation = !_animation;
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<EventItem> _eventItems =
        Provider.of<EventItemsProvider>(context).eventItems;

    if (_eventItems.isEmpty && !_loadingData) {
      _loadingData = true;

      widget.refreshIndicatorKey.currentState?.show();

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
      }).whenComplete(
        () => _loadingData = false,
      );
    }

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    bool checkTimeEventToAnimation(
      DateTime dateNow,
      String dateStartEvent,
      String dateEndEvent,
    ) {
      return DateTime.parse(dateStartEvent).toLocal().millisecondsSinceEpoch <
              dateNow.millisecondsSinceEpoch &&
          dateNow.millisecondsSinceEpoch <
              DateTime.parse(dateEndEvent).toLocal().millisecondsSinceEpoch;
    }

    return Center(
      child: ListView.builder(
        itemCount: _eventItems.length,
        itemBuilder: (context, index) {
          DateTime timeNow = DateTime.now();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                checkTimeEventToAnimation(timeNow, _eventItems[index].startDate,
                        _eventItems[index].endDate)
                    ? AnimatedContainer(
                        duration: const Duration(seconds: 3),
                        curve: Curves.easeIn,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: _animation
                                  ? _darkMode
                                      ? Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.8)
                                      : Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.4)
                                  : _darkMode
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.4),
                              blurRadius: 50,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ScheduleEvent(_eventItems[index]),
                      )
                    : ScheduleEvent(_eventItems[index]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Opacity(
                    opacity: 0.9,
                    child: Divider(
                      height: 1,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
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
