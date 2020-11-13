import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class InfoItemsProvider with ChangeNotifier {
  List<InfoItem> _infoItems = [];
  List<InfoItem> get infoItems => [..._infoItems];
  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    bool reload = false,
  }) async {
    _infoItems = await _contentfulService.getInfoItems(
      howMany: howMany,
      reload: reload,
    );
    notifyListeners();
  }
}
