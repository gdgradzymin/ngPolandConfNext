import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    const _url =
        'https://cdn.contentful.com/spaces/87a5voy5in4s/environments/master/entries?access_token=b21c9654f0c3a9b02d30e387e6d99c010c5f83e0f83e0b3cb2431dfa5d3b2914&content_type=simpleContent&locale=en-US&fields.myId=ng-girls-workshops&fields.confId=2019&limit=1';

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
