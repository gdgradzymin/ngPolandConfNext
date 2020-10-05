import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

final String _accessToken = FlutterConfig.get('access_token');
final String _spaceId = FlutterConfig.get('space_id');

class NgGirlsProvider with ChangeNotifier {
  String _title = '';
  String _content = '';

  get getTitle {
    return _title;
  }

  get getContent {
    return _content;
  }

  Future<void> getNgGirlsData() async {
    final _url =
        'https://cdn.contentful.com/spaces/${_spaceId}/environments/master/entries?access_token=${_accessToken}&content_type=simpleContent&locale=en-US&fields.myId=ng-girls-workshops&fields.confId=2019&limit=1';

    http.Response response = await http.get(_url);

    try {
      var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));
      _title = dataDecode['items'][0]['fields']['title'];
      _content = dataDecode['items'][0]['fields']['text'];
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
