import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class SimpleContentProvider with ChangeNotifier {
  Map<String, SimpleContent> _simpleContent = {};

  Map<String, SimpleContent> get simpleContent => _simpleContent;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    String myId,
    String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      clear();
    }

    _simpleContent = await _contentfulService.getSimpleContentById(
      myId: myId,
      confId: confId,
      refresh: refresh,
    ) as Map<String, SimpleContent>;

    notifyListeners();
  }

  void clear() {
    _simpleContent = {};
    notifyListeners();
  }
}
