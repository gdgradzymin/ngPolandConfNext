import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/simpleContent.dart';
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
  @override
  void initState() {
    Provider.of<SimpleContentProvider>(context, listen: false).fetchData(
      myId: 'ng-girls-workshops',
      confId: '2019',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleContent _simpleContent = Provider.of<SimpleContentProvider>(context)
            .simpleContent['ng-girls-workshops'] ??
        null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () async =>
            await Provider.of<SimpleContentProvider>(context, listen: false)
                .fetchData(
          myId: 'ng-girls-workshops',
          confId: '2019',
          refresh: true,
        ),
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
                      ? CircularProgressIndicator()
                      : Text(
                          _simpleContent.text,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
