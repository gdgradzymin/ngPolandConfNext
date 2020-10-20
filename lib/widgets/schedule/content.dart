import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/eventItems.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/schedule/event.dart';
import 'package:provider/provider.dart';

class ScheduleContent extends StatefulWidget {
  ScheduleContent({this.eventItems});

  final List<EventItem> eventItems;

  @override
  _ScheduleContentState createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<ScheduleContent> {
  Timer _timer;

  bool _animation = false;

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

    bool checkTimeEventToAnimation(
      DateTime dateNow,
      String dateStartEvent,
      String dateEndEvent,
    ) {
      return DateTime.parse(dateStartEvent).millisecondsSinceEpoch <
              dateNow.add(dateNow.timeZoneOffset).millisecondsSinceEpoch &&
          dateNow.add(dateNow.timeZoneOffset).millisecondsSinceEpoch <
              DateTime.parse(dateEndEvent).millisecondsSinceEpoch;
    }

    return Center(
      child: widget.eventItems.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: widget.eventItems.length,
              itemBuilder: (context, index) {
                DateTime timeNow = DateTime.now();

                return Column(
                  children: [
                    checkTimeEventToAnimation(
                            timeNow,
                            widget.eventItems[index].startDate,
                            widget.eventItems[index].endDate)
                        ? AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            curve: Curves.easeIn,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: _animation
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).primaryColor,
                                  blurRadius: 50,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ScheduleEvent(widget.eventItems[index]),
                          )
                        : ScheduleEvent(widget.eventItems[index]),
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
                );
              },
            ),
    );
  }
}
