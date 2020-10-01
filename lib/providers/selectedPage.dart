import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/pages.dart';

class SelectedPage with ChangeNotifier {
  Pages _selectedPage = Pages(name: PagesName.home, number: 0);

  Pages get getPage {
    return _selectedPage;
  }

  void changeSelected({PagesName name}) {
    _selectedPage = Pages.setPage(pagesName: name);

    notifyListeners();
  }
}
