import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/pages.dart';
import 'package:ngPolandConf/providers/selectedPage.dart';
import 'package:ngPolandConf/providers/themeManager.dart';
import 'package:provider/provider.dart';

class HomeButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final PagesName selectedPage;
  final String routeName;

  HomeButton({
    this.name,
    this.icon,
    this.selectedPage,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<SelectedPage>(context, listen: false)
            .changeSelected(name: selectedPage);
        Navigator.of(context).pushReplacementNamed(routeName);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Provider.of<ThemeNotifier>(context).darkTheme
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor,
            size: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            name,
            style: TextStyle(
              color: Provider.of<ThemeNotifier>(context).darkTheme
                  ? Colors.white
                  : Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
