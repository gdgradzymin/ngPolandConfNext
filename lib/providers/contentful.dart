import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

enum EventContentTypes {
  SPEAKER,
  WORKSHOP,
  EVENT_ITEM,
  SIMPLE_CONTENT,
  INFO_ITEM,
  VERSION
}

enum EventItemType {
  NGPOLAND,
  JSPOLAND,
}

final String _accessToken = FlutterConfig.get('access_token');
final String _spaceId = FlutterConfig.get('space_id');

final String _url = 'https://cdn.contentful.com/';

final String _contentfulEntries =
    '${_url}spaces/$_spaceId/environments/master/entries?access_token=$_accessToken';

class ContentfulService with ChangeNotifier {
  // Data Contentfull

  List<InfoItem> _infoItems;

  List<InfoItem> get getinfoItems => _infoItems;

  SimpleContent _simpleContent;

  SimpleContent get getSimpleContent => _simpleContent;

  //

  String getStringFromEventContentTypes(EventContentTypes eventContentTypes) {
    if (eventContentTypes == EventContentTypes.SPEAKER) {
      return "speaker";
    } else if (eventContentTypes == EventContentTypes.WORKSHOP) {
      return "workshop";
    } else if (eventContentTypes == EventContentTypes.EVENT_ITEM) {
      return "eventItem";
    } else if (eventContentTypes == EventContentTypes.SIMPLE_CONTENT) {
      return "simpleContent";
    } else if (eventContentTypes == EventContentTypes.INFO_ITEM) {
      return "infoItem";
    } else if (eventContentTypes == EventContentTypes.VERSION) {
      return "version";
    }
    return "Unknown";
  }

  String _contentfull({
    String contentType,
    String locale = 'en-US',
    List<String> fields,
    String limit = '1',
  }) {
    String stringfields = '';

    for (var field in fields) {
      stringfields = stringfields + '&fields.' + field;
    }

    return '&content_type=$contentType&locale=$locale$stringfields&limit=$limit';
  }

  Future<void> getInfoItems({int howMany, String confId}) async {
    http.Response response = await http.get(_contentfulEntries +
        _contentfull(
          contentType: getStringFromEventContentTypes(
            EventContentTypes.INFO_ITEM,
          ),
          fields: ['confId=$confId'],
          limit: howMany.toString(),
        ));

    try {
      var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // Problem
      for (var item in dataDecode) {
        _infoItems.add(
          InfoItem(
            title: item['items']['fields']['title'],
            ordre: item['items']['fields']['title'],
            icon: item['items']['fields']['title'],
            description: item['items']['fields']['title'],
            confId: item['items']['fields']['title'],
            urlLink: item['items']['fields']['title'],
          ),
        );
      }

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> getSimpleContentById({String myId, String confId}) async {
    http.Response response = await http.get(_contentfulEntries +
        _contentfull(
          contentType: getStringFromEventContentTypes(
            EventContentTypes.SIMPLE_CONTENT,
          ),
          fields: ['myId=$myId', 'confId=$confId'],
        ));

    try {
      var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));
      _simpleContent = SimpleContent(
        myId: dataDecode['items'][0]['fields']['myId'],
        title: dataDecode['items'][0]['fields']['title'],
        text: dataDecode['items'][0]['fields']['text'],
        confId: dataDecode['items'][0]['fields']['confId'],
      );

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
