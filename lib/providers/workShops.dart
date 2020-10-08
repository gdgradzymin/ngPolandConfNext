import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class WorkShopsProvider with ChangeNotifier {
  List<WorkShop> _workShopItems = [];

  List<WorkShop> get workShopItems => _workShopItems;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      clear();
    }

    _workShopItems = await _contentfulService.getWorkshops(
      howMany: howMany,
      confId: confId,
      refresh: refresh,
    );

    notifyListeners();
  }

  void clear() {
    _workShopItems = [];
    notifyListeners();
  }
}
