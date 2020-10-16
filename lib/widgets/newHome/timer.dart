import 'dart:async';

import 'package:flutter/material.dart';

class HomeTimer extends StatefulWidget {
  @override
  _HomeTimerState createState() => _HomeTimerState();
}

class _HomeTimerState extends State<HomeTimer> {
  Timer _timer;

  Duration duration;

  void startTimeout() {
    var duration = const Duration(seconds: 1);
    _timer = Timer.periodic(
      duration,
      (Timer timer) => setState(() {
        if (100 < 1) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$time',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          format,
          style: TextStyle(
            color: color,
            fontSize: 15,
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
    int _millisecondsSinceEpochToEvent =
        DateTime.parse('2020-11-18 13:00:00z').millisecondsSinceEpoch -
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
          time: DateTime.fromMillisecondsSinceEpoch(
                  _millisecondsSinceEpochToEvent)
              .hour,
          format: 'HOURS',
          color: const Color.fromRGBO(255, 193, 7, 1),
        ),
        timeField(
          time: DateTime.fromMillisecondsSinceEpoch(
                  _millisecondsSinceEpochToEvent)
              .minute,
          format: 'MINUTES',
          color: const Color.fromRGBO(0, 193, 193, 1),
        ),
        timeField(
          time: DateTime.fromMillisecondsSinceEpoch(
                  _millisecondsSinceEpochToEvent)
              .second,
          format: 'SECONDS',
          color: const Color.fromRGBO(139, 195, 74, 1),
        ),
      ],
    );
  }
}
