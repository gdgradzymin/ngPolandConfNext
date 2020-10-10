import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

class WorkShops extends StatefulWidget {
  static const routeName = '/WorkShops';

  final String title;

  WorkShops({Key key, this.title}) : super(key: key);

  @override
  _WorkShopsState createState() => _WorkShopsState();
}

class _WorkShopsState extends State<WorkShops> {
  @override
  void initState() {
    Provider.of<WorkShopsProvider>(context, listen: false).fetchData(
      howMany: 999,
      confId: '2019',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<WorkShop> _workShopsItems =
        Provider.of<WorkShopsProvider>(context).workShopItems ?? null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<WorkShopsProvider>(context, listen: false).fetchData(
          howMany: 999,
          confId: '2019',
          refresh: true,
        ),
        child: Center(
          child: ListView.builder(
            itemCount: _workShopsItems.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      child: CachedNetworkImage(
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Image.asset('assets/images/person.png'),
                        imageUrl:
                            'http:${_workShopsItems[index].speaker.photoFileUrl}',
                      ),
                    ),
                    title: Text(
                      _workShopsItems[index].title,
                      style: TextStyle(
                        color: Provider.of<ThemeNotifier>(context).darkTheme
                            ? Theme.of(context).accentColor
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text(_workShopsItems[index].speaker.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(_workShopsItems[index].description),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).accentColor,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
