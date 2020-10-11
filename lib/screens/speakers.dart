import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/speakers.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/screens/speakerDetails.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:ng_poland_conf_next/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Speakers extends StatefulWidget {
  static const routeName = '/Speakers';

  final String title;

  Speakers({Key key, this.title}) : super(key: key);

  @override
  _SpeakersState createState() => _SpeakersState();
}

class _SpeakersState extends State<Speakers> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  void initState() {
    Provider.of<SpeakersProvider>(context, listen: false)
        .fetchData(
      howMany: 999,
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
    List<Speaker> _speakers = Provider.of<SpeakersProvider>(context).speakers;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      drawer: DrawerNg(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<SpeakersProvider>(context, listen: false)
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
          child: _speakers.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _speakers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              SpeakerDetails.routeName,
                              arguments: _speakers[index],
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            child: Hero(
                              tag: 'image' + _speakers[index].name,
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Image.asset('assets/images/person.png'),
                                imageUrl:
                                    'http:${_speakers[index].photoFileUrl}',
                              ),
                            ),
                          ),
                          title: Hero(
                            tag: 'name' + _speakers[index].name,
                            flightShuttleBuilder: _flightShuttleBuilder,
                            child: Text(
                              _speakers[index].name,
                              style: TextStyle(
                                color: Provider.of<ThemeNotifier>(context)
                                        .darkTheme
                                    ? Theme.of(context).accentColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                          subtitle: Hero(
                            tag: 'role' + _speakers[index].name,
                            flightShuttleBuilder: _flightShuttleBuilder,
                            child: Text(_speakers[index].role),
                          ),
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
