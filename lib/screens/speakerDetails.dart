import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:provider/provider.dart';

class SpeakerDetails extends StatelessWidget {
  static const routeName = '/SpeakerDetails';

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
    Speaker _speaker = ModalRoute.of(context).settings.arguments as Speaker;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'name' + _speaker.name,
          flightShuttleBuilder: _flightShuttleBuilder,
          child: Text(
            _speaker.name,
            style: TextStyle(
              color: Provider.of<ThemeNotifier>(context).darkTheme
                  ? Theme.of(context).accentColor
                  : Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Hero(
                tag: 'image' + _speaker.name,
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Image.asset('assets/images/person.png'),
                  imageUrl: 'http:${_speaker.photoFileUrl}',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Hero(
              tag: 'role' + _speaker.name,
              flightShuttleBuilder: _flightShuttleBuilder,
              child: Text(
                _speaker.role,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(_speaker.bio),
            ),
          ],
        ),
      ),
    );
  }
}
