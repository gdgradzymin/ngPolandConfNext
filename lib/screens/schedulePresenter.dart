import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:url_launcher/url_launcher.dart';

class SchedulePresenter extends StatelessWidget {
  static const routeName = '/SchedulePresenter';

  @override
  Widget build(BuildContext context) {
    var _data =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    Speaker _speaker = _data['speaker'] as Speaker;

    return Scaffold(
      appBar: AppBar(),
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
                  _data['title'].toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: _speaker.photoFileUrl == null
                              ? Image.asset(
                                  'assets/images/person.png',
                                  width: double.infinity,
                                )
                              : CachedNetworkImage(
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Image.asset('assets/images/person.png'),
                                  imageUrl: 'http:${_speaker.photoFileUrl}',
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
                              launch(_speaker.urlTwitter);
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
              Text(
                _speaker.role,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: _data['description'] != null
                    ? Text(_data['description'].toString())
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        child: FittedBox(child: _data['icon'] as Icon),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
