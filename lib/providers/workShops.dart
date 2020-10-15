import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class WorkshopsProvider with ChangeNotifier {
  List<Workshop> _workshopItems = [];

  List<Workshop> get workshopItems => _workshopItems;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      _workshopItems = await _contentfulService.getWorkshops(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _workshopItems = _err.localdata as List<Workshop>;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  Future refreshData({
    @required int howMany,
    @required String confId,
  }) async {
    clear();

    try {
      _workshopItems = await _contentfulService.getWorkshops(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _workshopItems = _err.localdata as List<Workshop>;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear() {
    _workshopItems = [];
    notifyListeners();
  }
}
