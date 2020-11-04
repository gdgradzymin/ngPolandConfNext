import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Presenter extends StatelessWidget {
  static const routeName = '/Presenter';

  Presenter({
    this.data,
    this.speaker,
  });

  final Map<String, Object> data;
  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    // var _data = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    var _darkTheme = Provider.of<ThemeNotifier>(context).darkTheme;

    // Speaker _speaker = _data['speaker'] as Speaker;

    return Scaffold(
      appBar: AppBar(
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
                child: Text(
                  data['title'] != null
                      ? data['title'].toString()
                      : speaker.name,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: _darkTheme
                            ? Theme.of(context).accentColor
                            : Theme.of(context).primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Stack(
                    children: [
                      Center(
                        child: Hero(
                          tag: speaker.photoFileUrl,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: speaker.photoFileUrl == null
                                ? Image.asset(
                                    'assets/images/person.png',
                                    width: double.infinity,
                                  )
                                : CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Image.asset('assets/images/person.png'),
                                    imageUrl: 'http:${speaker.photoFileUrl}',
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            onPressed: () {
                              launch(speaker.urlTwitter);
                            },
                            color: Colors.white,
                            height: 50,
                            minWidth: 50,
                            child: const Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  speaker.role,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: data['description'] != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          data['description'].toString(),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    : speaker.bio != null
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(speaker.bio,
                                style: Theme.of(context).textTheme.bodyText2),
                          )
                        : Container(
                            padding: const EdgeInsets.only(top: 40, bottom: 20),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            child: FittedBox(
                              child: Opacity(
                                  opacity: 0.1, child: data['icon'] as Icon),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
