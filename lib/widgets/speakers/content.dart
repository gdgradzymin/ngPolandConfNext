import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/speakers.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:provider/provider.dart';

class SpeakersContent extends StatelessWidget {
  SpeakersContent(
    this.refreshIndicatorKey,
  );

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  bool _loadingData = false;

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
  Widget build(BuildContext context) {
    List<Speaker> _speakers = Provider.of<SpeakersProvider>(context).speakers;

    if (_speakers.isEmpty && !_loadingData) {
      _loadingData = true;

      refreshIndicatorKey.currentState?.show();

      Provider.of<SpeakersProvider>(context, listen: false)
          .fetchData(
        howMany: 999,
        confId: '2019',
      )
          .catchError((Object err) {
        ConnectionSnackBar.show(
          context: context,
          message: err.toString(),
        );
      });
    }

    return ListView.builder(
      itemCount: _speakers.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              onTap: () {
                Navigator.of(context).pushNamed(
                  Presenter.routeName,
                  arguments: {
                    'speaker': _speakers[index],
                  },
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
                    imageUrl: 'http:${_speakers[index].photoFileUrl}',
                  ),
                ),
              ),
              title: Hero(
                tag: 'name' + _speakers[index].name,
                flightShuttleBuilder: _flightShuttleBuilder,
                child: Text(
                  _speakers[index].name,
                  style: TextStyle(
                      color: Provider.of<ThemeNotifier>(context).darkTheme
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              subtitle: Hero(
                tag: 'role' + _speakers[index].name,
                flightShuttleBuilder: _flightShuttleBuilder,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(_speakers[index].role,
                        style: const TextStyle(fontSize: 12))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  height: 0,
                  color: Theme.of(context).accentColor,
                )),
          ],
        );
      },
    );
  }
}
