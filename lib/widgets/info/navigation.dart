import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ng_poland_conf_next/screens/info.dart';

class InfoNavigation extends StatelessWidget {
  final InfoContents currentContent;
  final Function changeContent;

  InfoNavigation({
    this.currentContent,
    this.changeContent,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
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
