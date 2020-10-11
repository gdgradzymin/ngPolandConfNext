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
  }) async {
    try {
      _speakers = await _contentfulService.getSpeakers(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _speakers = _err.localdata as List<Speaker>;

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
      _speakers = await _contentfulService.getSpeakers(
        howMany: howMany,
        confId: confId,
      );
    } catch (err) {
      var _err = err as Failure;

      _speakers = _err.localdata as List<Speaker>;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear() {
    _speakers = [];
    notifyListeners();
  }
}
