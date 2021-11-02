import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/conferences.dart';
import 'package:ngPolandConf/services/contentful.dart';

class ConferencesProvider with ChangeNotifier {
  Conferences _conferencesData;

  Conferences get conferencesData => _conferencesData;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData() async {
    if (_conferencesData == null) {
      _conferencesData = await _contentfulService.conferencesData();
      notifyListeners();
    }
  }
}
