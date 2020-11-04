import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/shared/widgets/emptyListInformation.dart';
import 'package:provider/provider.dart';

class WorkshopsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Workshop> _workshopsItems =
        Provider.of<WorkshopsProvider>(context).workshopItems;

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    return _workshopsItems == null
        ? EmptyListInformation()
        : ListView.builder(
            itemCount: _workshopsItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Presenter.routeName,
                            arguments: {
                              'speaker': _workshopsItems[index].speaker,
                            },
                          );
                        },
                        child: Hero(
                          tag: _workshopsItems[index].speaker.photoFileUrl,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset('assets/images/person.png'),
                              imageUrl:
                                  'http:${_workshopsItems[index].speaker.photoFileUrl}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _workshopsItems[index].title,
                        style: TextStyle(
                          color: Provider.of<ThemeNotifier>(context).darkTheme
                              ? Theme.of(context).accentColor
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.010,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: _workshopsItems[index].speaker.name,
                                  style: TextStyle(
                                      color: _darkMode
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color
                                              .withOpacity(0.7)
                                          : Theme.of(context).primaryColor,
                                      fontSize: 13),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pushNamed(
                                        Presenter.routeName,
                                        arguments: {
                                          'speaker':
                                              _workshopsItems[index].speaker,
                                        },
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
                      color: Theme.of(context).dividerTheme.color,
                    )
                  ],
                ),
              );
            },
          );
  }
}
