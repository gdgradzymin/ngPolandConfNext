import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class NgGirlsProvider with ChangeNotifier {
  SimpleContent _data;

  SimpleContent get data => _data;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    String myId,
    String confId,
  }) async {
    try {
      _data = await _contentfulService.getSimpleContentById(
        myId: myId,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _data = _err.localdata as SimpleContent;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  Future refreshData({
    String myId,
    String confId,
  }) async {
    clear();

    try {
      _data = await _contentfulService.getSimpleContentById(
        myId: myId,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _data = _err.localdata as SimpleContent;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear() {
    _data = null;
    notifyListeners();
  }
}
