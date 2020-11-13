import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class NgGirlsProvider with ChangeNotifier {
  SimpleContent _data;

  SimpleContent get data => _data;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    String myId,
    bool reload = false,
  }) async {
    _data = await _contentfulService.getSimpleContentById(
      myId: myId,
      reload: reload,
    );
    notifyListeners();
  }
}
