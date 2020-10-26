import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class SpeakersProvider with ChangeNotifier {
  List<Speaker> _speakers = [];

  bool _loadedSpeakers = false;

  List<Speaker> get speakers =>
      _loadedSpeakers && _speakers.isEmpty ? null : _speakers;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    if (_speakers.isNotEmpty) {
      clear();
    }

    try {
      _speakers = await _contentfulService.getSpeakers(
        howMany: howMany,
        confId: confId,
      );

      _loadedSpeakers = true;
    } catch (err) {
      var _err = err as Failure;

      _speakers = _err.localdata as List<Speaker>;

      _loadedSpeakers = true;

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear() {
    _speakers = [];

    _loadedSpeakers = true;

    notifyListeners();
  }
}
