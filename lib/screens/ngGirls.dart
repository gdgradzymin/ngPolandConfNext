import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/contentful.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

class NgGirls extends StatelessWidget {
  static const routeName = '/NgGirls';

  final String title;

  NgGirls({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SimpleContent _simpleContent = Provider.of<ContentfulService>(context)
            .simpleContent['ng-girls-workshops'] ??
        null;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () async =>
            await Provider.of<ContentfulService>(context, listen: false)
                .getSimpleContentById(
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
