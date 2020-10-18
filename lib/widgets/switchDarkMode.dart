import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/providers/themeManager.dart';
import 'package:provider/provider.dart';

class SwitchDarkMode extends StatefulWidget {
  @override
  _SwitchDarkModeState createState() => _SwitchDarkModeState();
}

class _SwitchDarkModeState extends State<SwitchDarkMode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<ThemeNotifier>(
            builder: (BuildContext context, ThemeNotifier theme, _) {
              return InkWell(
                onTap: () => theme.darkTheme = !theme.darkTheme,
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (theme.darkTheme)
                        const Positioned(
                          left: 10.0,
                          child: Text(
                            'ON',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (!theme.darkTheme)
                        const Positioned(
                          left: 35.0,
                          child: Text(
                            'OFF',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left: theme.darkTheme ? 25.0 : 0.0,
                        right: theme.darkTheme ? 0.0 : 25.0,
                        curve: Curves.easeIn,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: theme.darkTheme
                                ? Theme.of(context).accentColor
                                : Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Text(
            'Dark Mode',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
