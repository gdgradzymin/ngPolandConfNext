import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/providers/workShops.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/widgets/connection.dart';
import 'package:provider/provider.dart';

class WorkshopsContent extends StatelessWidget {
  WorkshopsContent({
    this.refreshIndicatorKey,
  });

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  bool _loadingData = false;

  @override
  Widget build(BuildContext context) {
    List<Workshop> _workshopsItems =
        Provider.of<WorkshopsProvider>(context).workshopItems;

    if (_workshopsItems.isEmpty && !_loadingData) {
      _loadingData = true;

      refreshIndicatorKey.currentState?.show();

      Provider.of<WorkshopsProvider>(context, listen: false)
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

    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;
    return Center(
      child: ListView.builder(
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
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
                                color: _darkMode ? Colors.white : Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamed(
                                    Presenter.routeName,
                                    arguments: {
                                      'speaker': _workshopsItems[index].speaker,
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
                  color: Theme.of(context).accentColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
