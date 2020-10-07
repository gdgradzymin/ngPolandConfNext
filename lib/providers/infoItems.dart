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
    bool refresh = false,
  }) async {
    if (refresh) {
      clear();
    }

    _infoItems = await _contentfulService.getInfoItems(
      howMany: howMany,
      confId: confId,
      refresh: refresh,
    ) as List<InfoItem>;

    notifyListeners();
  }

  void clear() {
    _infoItems = [];
    notifyListeners();
  }
}
