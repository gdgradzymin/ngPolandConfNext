import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/screens/presenter.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/speakers.dart';
import 'package:ngPolandConf/shared/widgets/emptyListInformation.dart';
import 'package:provider/provider.dart';

class SpeakersContent extends StatefulWidget {
  SpeakersContent(
    this.refreshIndicatorKey,
  );

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  _SpeakersContentState createState() => _SpeakersContentState();
}

class _SpeakersContentState extends State<SpeakersContent> {
  @override
  void initState() {
    widget.refreshIndicatorKey.currentState?.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Speaker> _speakers = Provider.of<SpeakersProvider>(context).speakers;

    return _speakers == null
        ? EmptyListInformation()
        : ListView.builder(
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
                    leading: Hero(
                      tag: _speakers[index].photoFileUrl,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Image.asset('assets/images/person.png'),
                          imageUrl: 'http:${_speakers[index].photoFileUrl}',
                        ),
                      ),
                    ),
                    title: Text(
                      _speakers[index].name,
                      style: TextStyle(
                          color: Provider.of<ThemeNotifier>(context).darkTheme
                              ? Theme.of(context).accentColor
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(_speakers[index].role,
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      height: 0,
                      color: Theme.of(context).dividerTheme.color,
                    ),
                  ),
                ],
              );
            },
          );
  }
}
