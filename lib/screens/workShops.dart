import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:ng_poland_conf_next/widgets/schedule/animatedBottomNav.dart';
import 'package:provider/provider.dart';

class Workshops extends StatefulWidget {
  static const routeName = '/Workshops';

  final String title;

  Workshops({Key key, this.title}) : super(key: key);

  @override
  _WorkshopsState createState() => _WorkshopsState();
}

class _WorkshopsState extends State<Workshops> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<WorkshopsProvider>(context, listen: false)
        .fetchData(
      howMany: 999,
      type: EventItemType.NGPOLAND,
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
    List<Workshop> _workshopsItems =
        Provider.of<WorkshopsProvider>(context).workshopItems ?? null;

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<WorkshopsProvider>(context, listen: false)
            .refreshData(
          howMany: 999,
          confId: '2019',
        )
            .catchError((Object err) {
          ConnectionSnackBar.show(
            context: context,
            message: err.toString(),
            scaffoldKeyCurrentState: _scaffoldKey.currentState,
          );
        }),
        child: Center(
          child: _workshopsItems.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _workshopsItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/SpeakerDetails',
                                    arguments: _workshopsItems[index].speaker,
                                  );
                                },
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Image.asset('assets/images/person.png'),
                                  imageUrl:
                                      'http:${_workshopsItems[index].speaker.photoFileUrl}',
                                ),
                              ),
                            ),
                            title: Text(
                              _workshopsItems[index].title,
                              style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context)
                                        .darkTheme
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            _workshopsItems[index].speaker.name,
                                        style: TextStyle(
                                          color: _darkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).pushNamed(
                                              '/SpeakerDetails',
                                              arguments: _workshopsItems[index]
                                                  .speaker,
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Text(_workshopsItems[index].description),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          Divider(
                            height: 0,
                            color: Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        deviceSize: MediaQuery.of(context).size,
        provider: WorkshopsProvider,
      ),
    );
  }
}
