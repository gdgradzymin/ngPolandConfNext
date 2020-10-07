import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class SpeakersProvider with ChangeNotifier {
  List<Speaker> _speakers = [];

  List<Speaker> get speakers => _speakers;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      clear();
    }

    _speakers = await _contentfulService.getSpeakers(
      howMany: howMany,
      confId: confId,
      refresh: refresh,
    ) as List<Speaker>;

    notifyListeners();
  }

  void clear() {
    _speakers = [];
    notifyListeners();
  }
}
