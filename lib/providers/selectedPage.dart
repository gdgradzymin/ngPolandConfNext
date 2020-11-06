import 'package:flutter/material.dart';
import 'package:ngPolandConf/models/pages.dart';
import 'package:ngPolandConf/screens/newHome.dart';

class SelectedPage with ChangeNotifier {
  Pages _selectedPage = Pages(name: Home.routeName);

  Pages get getPage {
    return _selectedPage;
  }

  void changeSelected({String name}) {
    _selectedPage = Pages.setPage(pagesName: name);

    notifyListeners();
  }
}
