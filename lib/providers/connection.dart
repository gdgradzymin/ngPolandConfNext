import 'package:flutter/material.dart';

class Connection with ChangeNotifier {
  bool _status = true;
  int _viewedSnackBar = 0;

  bool get status => _status;

  bool _initialFetch = false;

  bool get initialFetch => _initialFetch;

  set initialFetch(bool isFetched) {
    _initialFetch = isFetched;
    notifyListeners();
  }

  set status(bool newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  int get viewedSnackBar => _viewedSnackBar;

  set viewedSnackBar(int value) {
    _viewedSnackBar = value;
    notifyListeners();
  }
}
