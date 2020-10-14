import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/ngGirls.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

class NgGirls extends StatefulWidget {
  static const routeName = '/NgGirls';

  final String title;

  NgGirls({Key key, this.title}) : super(key: key);

  @override
  _NgGirlsState createState() => _NgGirlsState();
}

class _NgGirlsState extends State<NgGirls> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<NgGirlsProvider>(context, listen: false)
        .fetchData(
      myId: 'ng-girls-workshops',
      confId: '2019',
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
    SimpleContent _simpleContent =
        Provider.of<NgGirlsProvider>(context).data ?? null;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () async =>
            await Provider.of<NgGirlsProvider>(context, listen: false)
                .refreshData(
          myId: 'ng-girls-workshops',
          confId: '2019',
        )
                .catchError((Object err) {
          ConnectionSnackBar.show(
            context: context,
            message: err.toString(),
            scaffoldKeyCurrentState: _scaffoldKey.currentState,
          );
        }),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/nggirls.png'),
                  ),
                  _simpleContent == null
                      ? const CircularProgressIndicator()
                      : Text(
                          _simpleContent.text,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
