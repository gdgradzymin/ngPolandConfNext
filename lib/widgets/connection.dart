import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/providers/connection.dart';
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
                  FontAwesomeIcons.wifi,
                  color: Theme.of(context).errorColor,
                );
        },
      ),
    );
  }
}

class ConnectionSnackBar {
  static void show({
    @required BuildContext context,
    String message = 'Problem connection Internet.',
    ScaffoldState scaffoldKeyCurrentState,
  }) {
    int viewedSnackBar =
        Provider.of<Connection>(context, listen: false).viewedSnackBar;

    bool status = Provider.of<Connection>(context, listen: false).status;

    if (viewedSnackBar == 0 && status == false) {
      if (scaffoldKeyCurrentState == null) {
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).accentColor.withAlpha(99),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));
        viewedSnackBar = 1;
      } else {
        scaffoldKeyCurrentState.removeCurrentSnackBar();
        scaffoldKeyCurrentState.showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).accentColor.withAlpha(99),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));
        viewedSnackBar = 1;
      }

      // Update viewedSnackBar in Provider
      Provider.of<Connection>(context, listen: false).viewedSnackBar =
          viewedSnackBar;
    }
  }
}
