import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/ngGirls.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

class NgGirls extends StatelessWidget {
  static const routeName = '/NgGirls';

  final String title;

  NgGirls({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _ngGirlsContent = Provider.of<NgGirlsProvider>(context).getContent;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/nggirls.png'),
            ),
            _ngGirlsContent == ''
                ? CircularProgressIndicator()
                : Text(
                    Provider.of<NgGirlsProvider>(context).getContent,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
          ],
        ),
      ),
    );
  }
}
