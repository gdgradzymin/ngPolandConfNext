import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:ng_poland_conf_next/providers/workShops.dart';
import 'package:ng_poland_conf_next/screens/presenter.dart';
import 'package:ng_poland_conf_next/widgets/connection.dart';
import 'package:provider/provider.dart';

class WorkshopsContent extends StatefulWidget {
  WorkshopsContent({this.workshopsItems});

  final List<Workshop> workshopsItems;

  @override
  _WorkshopsContentState createState() => _WorkshopsContentState();
}

class _WorkshopsContentState extends State<WorkshopsContent> {
  @override
  Widget build(BuildContext context) {
    if (widget.workshopsItems.isEmpty) {
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
      child: widget.workshopsItems.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: widget.workshopsItems.length,
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
                                'speaker': widget.workshopsItems[index].speaker,
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
                                  'http:${widget.workshopsItems[index].speaker.photoFileUrl}',
                            ),
                          ),
                        ),
                        title: Text(
                          widget.workshopsItems[index].title,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.010,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget
                                        .workshopsItems[index].speaker.name,
                                    style: TextStyle(
                                      color: _darkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).pushNamed(
                                          Presenter.routeName,
                                          arguments: {
                                            'speaker': widget
                                                .workshopsItems[index].speaker,
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
                      Text(widget.workshopsItems[index].description),
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
