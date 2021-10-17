import 'dart:async';

import 'package:flutter/material.dart';

class HomeTimer extends StatefulWidget {
  const HomeTimer({this.conferencesStartDate});

  final String conferencesStartDate;

  @override
  _HomeTimerState createState() => _HomeTimerState();
}

class _HomeTimerState extends State<HomeTimer> {
  Timer _timer;

  Duration duration;

  int _millisecondsSinceEpochToEvent;

  void startTimeout() {
    var timerDuration = const Duration(seconds: 1);
    _timer = Timer.periodic(
      timerDuration,
      (Timer timer) => setState(() {
        if (duration.inSeconds <= 0) {
          timer.cancel();
        }
      }),
    );
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  Widget timeField({
    dynamic time,
    String format,
    Color color,
  }) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$time',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color.withOpacity(0.85),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text(
          format,
          style: TextStyle(
            color: color.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _millisecondsSinceEpochToEvent =
        DateTime.parse(widget.conferencesStartDate ?? '2021-11-18 10:00:00z').add(DateTime.now().timeZoneOffset).millisecondsSinceEpoch -
                    DateTime.now().millisecondsSinceEpoch <
                0
            ? 0
            : DateTime.parse(widget.conferencesStartDate ?? '2021-11-18 10:00:00z').add(DateTime.now().timeZoneOffset).millisecondsSinceEpoch -
                DateTime.now().millisecondsSinceEpoch;

    duration = Duration(
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0,
      milliseconds: _millisecondsSinceEpochToEvent,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        timeField(
          time: duration.inDays,
          format: 'DAYS',
          color: const Color.fromRGBO(255, 0, 122, 1),
        ),
        timeField(
          time: DateTime.fromMillisecondsSinceEpoch(_millisecondsSinceEpochToEvent, isUtc: true).hour,
          format: 'HOURS',
          color: const Color.fromRGBO(255, 193, 7, 1),
        ),
        timeField(
          time: DateTime.fromMillisecondsSinceEpoch(_millisecondsSinceEpochToEvent).minute,
          format: 'MINUTES',
          color: const Color.fromRGBO(0, 193, 193, 1),
        ),
        timeField(
          time: DateTime.fromMillisecondsSinceEpoch(_millisecondsSinceEpochToEvent).second,
          format: 'SECONDS',
          color: const Color.fromRGBO(139, 195, 74, 1),
        ),
      ],
    );
  }
}
