import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/providers/infoItems.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:ngPolandConf/shared/widgets/emptyListInformation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContent extends StatelessWidget {
  InfoContent({
    this.selectedContent,
    this.refreshIndicatorKey,
  });

  final InfoContents selectedContent;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  bool _loadingData = false;

  @override
  Widget build(BuildContext context) {
    List<InfoItem> _info = Provider.of<InfoItemsProvider>(context).infoItems;

    if (_info.isEmpty && !_loadingData) {
      _loadingData = true;

      Provider.of<InfoItemsProvider>(context, listen: false)
          .fetchData(howMany: 999, reload: true);
    }

    return Container(
      child: _info.isEmpty
          ? EmptyListInformation()
          : Column(
              children: [
                Text(
                  _info[selectedContent.index].title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Divider(
                  color: Theme.of(context).dividerTheme.color,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  _info[selectedContent.index].description,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                _info[selectedContent.index].urlLink != null
                    ? RichText(
                        text: TextSpan(
                          text: 'More Info: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'here',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(_info[selectedContent.index].urlLink);
                                },
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
