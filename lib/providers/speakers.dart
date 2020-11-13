import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class SpeakersProvider with ChangeNotifier {
  List<Speaker> _speakers = [];

  List<Speaker> get speakers => _speakers.isEmpty ? [] : [..._speakers];

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    bool reload = false,
  }) async {
    _speakers = await _contentfulService.getSpeakers(
      howMany: howMany,
      reload: reload,
    );

    notifyListeners();
  }
}
