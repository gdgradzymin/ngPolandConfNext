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

  List<InfoItem> _infoItems = [];

  List<InfoItem> get getinfoItems => _infoItems;

  List<EventItem> _eventItems = [];

  List<EventItem> get geteventItems => _eventItems;

  SimpleContent _simpleContent;

  SimpleContent get getSimpleContent => _simpleContent;

  List<WorkShop> _workShopItems = [];

  List<WorkShop> get getworkShopItems => _workShopItems;

  List<Speaker> _speakers = [];

  List<Speaker> get getspeakers => _speakers;

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

  String getStringFromEventItemType(EventItemType eventItemType) {
    if (eventItemType == EventItemType.NGPOLAND) {
      return "ngPoland";
    } else if (eventItemType == EventItemType.JSPOLAND) {
      return "jsPoland";
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
    if (_infoItems.isEmpty) {
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

        for (var item in dataDecode['items']) {
          _infoItems.add(
            InfoItem(
              title: item['fields']['title'],
              order: item['fields']['order'].toString(),
              icon: item['fields']['icon'],
              description: item['fields']['description'],
              confId: item['fields']['confId'],
              urlLink: item['fields']['urlLink'],
            ),
          );
        }

        notifyListeners();
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> getEventItems({
    int howMany,
    EventItemType type,
    String confId,
  }) async {
    if (_eventItems.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.EVENT_ITEM,
            ),
            fields: [
              'type=${getStringFromEventItemType(type)}',
              'confId=$confId'
            ],
            limit: howMany.toString(),
          ));

      try {
        var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (var item in dataDecode['items']) {
          print(item['fields']['title']);
          _eventItems.add(
            EventItem(
              title: item['fields']['title'],
              confId: item['fields']['confId'],
              type: item['fields']['type'],
              category: item['fields']['category'],
              shortDescription: item['fields']['shortDescription'],
              description: item['fields']['description'],
              startDate: item['fields']['startDate'],
              endDate: item['fields']['endDate'],
              speaker: Speaker(
                name: item['fields']['name'],
                confIds: item['fields']['confIds'],
                role: item['fields']['role'],
                bio: item['fields']['bio'],
                photoFileUrl: item['fields']['photoFileUrl'],
                photoTitle: item['fields']['photoTitle'],
                photoDescription: item['fields']['photoDescription'],
                email: item['fields']['email'],
                urlGithub: item['fields']['urlGithub'],
                urlLinkedIn: item['fields']['urlLinkedIn'],
                urlTwitter: item['fields']['urlTwitter'],
                urlWww: item['fields']['urlWww'],
              ),
            ),
          );
        }

        notifyListeners();
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> getSimpleContentById({String myId, String confId}) async {
    if (_simpleContent == null) {
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

  Future<void> getWorkshops({int howMany, String confId}) async {
    if (_workShopItems.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.WORKSHOP,
            ),
            fields: ['confId=$confId'],
            limit: howMany.toString(),
          ));

      try {
        var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (var item in dataDecode['items']) {
          _workShopItems.add(
            WorkShop(
              title: item['fields']['title'],
              confId: item['fields']['confId'],
              description: item['fields']['description'],
              speaker: Speaker(
                name: item['fields']['name'],
                confIds: item['fields']['confIds'],
                role: item['fields']['role'],
                bio: item['fields']['bio'],
                photoFileUrl: item['fields']['photoFileUrl'],
                photoTitle: item['fields']['photoTitle'],
                photoDescription: item['fields']['photoDescription'],
                email: item['fields']['email'],
                urlGithub: item['fields']['urlGithub'],
                urlLinkedIn: item['fields']['urlLinkedIn'],
                urlTwitter: item['fields']['urlTwitter'],
                urlWww: item['fields']['urlWww'],
              ),
              startDate: item['fields']['startDate'],
              endDate: item['fields']['endDate'],
              locationDescription: item['fields']['locationDescription'],
              pricePln: item['fields']['pricePln'].toString(),
            ),
          );
        }

        notifyListeners();
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> getSpeakers({int howMany, String confId}) async {
    if (_speakers.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.SPEAKER,
            ),
            fields: ['confIds=$confId'],
            limit: howMany.toString(),
          ));

      try {
        var dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (var item in dataDecode['items']) {
          _speakers.add(
            Speaker(
              name: item['fields']['name'],
              confIds: item['fields']['confIds'].toString(),
              role: item['fields']['role'],
              bio: item['fields']['bio'],
              photoFileUrl: item['fields']['photoFileUrl'],
              photoTitle: item['fields']['photoTitle'],
              photoDescription: item['fields']['photoDescription'],
              email: item['fields']['email'],
              urlGithub: item['fields']['urlGithub'],
              urlLinkedIn: item['fields']['urlLinkedIn'],
              urlTwitter: item['fields']['urlTwitter'],
              urlWww: item['fields']['urlWww'],
            ),
          );
        }

        notifyListeners();
      } catch (err) {
        print(err);
      }
    }
  }
}
