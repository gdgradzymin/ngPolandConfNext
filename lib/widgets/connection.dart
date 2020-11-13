import 'package:flutter/material.dart';
import 'package:ngPolandConf/providers/connection.dart';
import 'package:provider/provider.dart';

class ConnectionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      child: Consumer<Connection>(
        builder: (context, connection, _) {
          return connection.status
              ? const SizedBox()
              : Icon(
                  Icons.wifi_off,
                  color: Theme.of(context).errorColor,
                );
        },
      ),
    );
  }
}
