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
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        actions: [ConnectionStatus()],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Hero(
                  tag: 'image' + _speaker.name,
                  child: CachedNetworkImage(
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            Image.asset('assets/images/person.png'),
                    imageUrl: 'http:${_speaker.photoFileUrl}',
                  ),
                ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
