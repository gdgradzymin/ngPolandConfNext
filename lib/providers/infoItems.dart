import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class InfoItemsProvider with ChangeNotifier {
  List<InfoItem> _infoItems = [];

  List<InfoItem> get infoItems => _infoItems;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      _infoItems = await _contentfulService.getInfoItems(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _infoItems = _err.localdata as List<InfoItem>;

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
      _infoItems = await _contentfulService.getInfoItems(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _infoItems = _err.localdata as List<InfoItem>;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear() {
    _infoItems = [];
    notifyListeners();
  }
}
