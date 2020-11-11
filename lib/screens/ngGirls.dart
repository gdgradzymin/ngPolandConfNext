import 'package:flutter/material.dart';
import 'package:ngPolandConf/providers/ngGirls.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:ngPolandConf/widgets/drawer.dart';
import 'package:ngPolandConf/widgets/ngGirls/content.dart';
import 'package:provider/provider.dart';

class NgGirls extends StatelessWidget {
  static const routeName = '/NgGirls';

  final String title;

  NgGirls({Key key, this.title}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: const DrawerNg(
        pageName: NgGirls.routeName,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                child: Image.asset('assets/images/nggirls.png'),
                height: MediaQuery.of(context).size.height * 0.20,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () =>
                    Provider.of<NgGirlsProvider>(context, listen: false)
                        .refreshData(myId: 'ng-girls-workshops')
                        .catchError((Object err) {
                  ConnectionSnackBar.show(
                    context: context,
                    message: err.toString(),
                    scaffoldKeyCurrentState: _scaffoldKey.currentState,
                  );
                }),
                child: NgGirlsContent(_refreshIndicatorKey),
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
