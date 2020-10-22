import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:ngPolandConf/screens/info.dart';
import 'package:provider/provider.dart';

class InfoNavigation extends StatelessWidget {
  final InfoContents currentContent;
  final int whoColorIcon;
  final Function changeContent;

  InfoNavigation({
    this.currentContent,
    this.whoColorIcon,
    this.changeContent,
  });

  @override
  Widget build(BuildContext context) {
    bool _darkMode = Provider.of<ThemeNotifier>(context).darkTheme;

    return Center(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutBack,
              left: MediaQuery.of(context).size.width *
                  0.225 *
                  currentContent.index,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.225,
                height: 50,
                color: Theme.of(context).accentColor,
              ),
            ),
            Positioned(
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        changeContent(InfoContents.location);
                      },
                      child: Container(
                        height: double.infinity,
                        child: Icon(
                          Icons.location_on,
                          size: 27.5,
                          color: _darkMode
                              ? Colors.white
                              : whoColorIcon == 0
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        changeContent(InfoContents.workshops);
                      },
                      child: Container(
                        height: double.infinity,
                        child: Icon(
                          FontAwesomeIcons.laptopCode,
                          size: 27.5,
                          color: _darkMode
                              ? Colors.white
                              : whoColorIcon == 1
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        changeContent(InfoContents.tickets);
                      },
                      child: Container(
                        height: double.infinity,
                        child: Icon(
                          FontAwesomeIcons.ticketAlt,
                          size: 27.5,
                          color: _darkMode
                              ? Colors.white
                              : whoColorIcon == 2
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: InkWell(
                      onTap: () {
                        changeContent(InfoContents.contact);
                      },
                      child: Container(
                        height: double.infinity,
                        child: Icon(
                          Icons.comment,
                          size: 27.5,
                          color: _darkMode
                              ? Colors.white
                              : whoColorIcon == 3
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
