import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/providers/infoItems.dart';
import 'package:ng_poland_conf_next/screens/info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContent extends StatelessWidget {
  final InfoContents selectedContent;

  InfoContent({this.selectedContent});

  @override
  Widget build(BuildContext context) {
    List<InfoItem> _info = Provider.of<InfoItemsProvider>(context).infoItems;

    return Container(
      child: _info.isEmpty
          ? const SizedBox()
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
                  color: Theme.of(context).accentColor,
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
                RichText(
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
              ],
            ),
    );
  }
}
