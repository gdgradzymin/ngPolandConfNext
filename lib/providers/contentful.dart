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

final String _accessToken = FlutterConfig.get('access_token') as String;
final String _spaceId = FlutterConfig.get('space_id') as String;

const String _url = 'https://cdn.contentful.com/';

final String _contentfulEntries =
    '${_url}spaces/$_spaceId/environments/master/entries?access_token=$_accessToken';

class ContentfulService with ChangeNotifier {
  // Data Contentfull

  List<InfoItem> _infoItems = [];

  List<InfoItem> get infoItems => _infoItems;

  List<EventItem> _eventItems = [];

  List<EventItem> get eventItems => _eventItems;

  Map<String, SimpleContent> _simpleContent = {};

  Map<String, SimpleContent> get simpleContent => _simpleContent;

  List<WorkShop> _workShopItems = [];

  List<WorkShop> get workShopItems => _workShopItems;

  List<Speaker> _speakers = [];

  List<Speaker> get speakers => _speakers;

  //

  void _clear({EventContentTypes eventContentTypes}) {
    switch (eventContentTypes) {
      case EventContentTypes.SPEAKER:
        {
          _speakers = [];
          notifyListeners();
        }
        break;

      case EventContentTypes.WORKSHOP:
        {
          _workShopItems = [];
          notifyListeners();
        }
        break;

      case EventContentTypes.EVENT_ITEM:
        {
          _eventItems = [];
          notifyListeners();
        }
        break;

      case EventContentTypes.SIMPLE_CONTENT:
        {
          _simpleContent = {};
          notifyListeners();
        }
        break;

      case EventContentTypes.INFO_ITEM:
        {
          _infoItems = [];
          notifyListeners();
        }
        break;

      default:
        {
          print('Problem from clear Data.');
        }
    }
  }

  String getStringFromEventContentTypes(EventContentTypes eventContentTypes) {
    switch (eventContentTypes) {
      case EventContentTypes.SPEAKER:
        {
          return 'speaker';
        }
        break;

      case EventContentTypes.WORKSHOP:
        {
          return 'workshop';
        }
        break;

      case EventContentTypes.EVENT_ITEM:
        {
          return 'eventItem';
        }
        break;

      case EventContentTypes.SIMPLE_CONTENT:
        {
          return 'simpleContent';
        }
        break;

      case EventContentTypes.INFO_ITEM:
        {
          return 'infoItem';
        }
        break;

      case EventContentTypes.VERSION:
        {
          return 'version';
        }
        break;

      default:
        {
          return 'Unknown';
        }
    }
  }

  String getStringFromEventItemType(EventItemType eventItemType) {
    switch (eventItemType) {
      case EventItemType.NGPOLAND:
        {
          return 'ngPoland';
        }
        break;

      case EventItemType.JSPOLAND:
        {
          return 'jsPoland';
        }
        break;

      default:
        {
          return 'Unknown';
        }
    }
  }

  String _contentfull({
    String contentType,
    String locale = 'en-US',
    List<String> fields,
    String order = '',
    String limit = '1',
  }) {
    String stringfields = '';

    for (final String field in fields) {
      stringfields = stringfields + '&fields.' + field;
    }

    return '&content_type=$contentType&locale=$locale$stringfields&limit=$limit&order=$order';
  }

  Future<void> getInfoItems({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _clear(eventContentTypes: EventContentTypes.INFO_ITEM);
    }

    if (_infoItems.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.INFO_ITEM,
            ),
            fields: ['confId=$confId'],
            order: 'fields.order',
            limit: howMany.toString(),
          ));

      try {
        dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (final dynamic item in dataDecode['items']) {
          _infoItems.add(
            InfoItem(
              title: item['fields']['title'] as String,
              order: item['fields']['order'] as int,
              icon: item['fields']['icon'] as String,
              description: item['fields']['description'] as String,
              confId: item['fields']['confId'] as String,
              urlLink: item['fields']['urlLink'] as String,
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
    bool refresh = false,
  }) async {
    if (refresh) {
      _clear(eventContentTypes: EventContentTypes.EVENT_ITEM);
    }

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
            order: 'fields.startDate',
            limit: howMany.toString(),
          ));

      try {
        dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (final dynamic item in dataDecode['items']) {
          print(item['fields']['title']);
          _eventItems.add(
            EventItem(
              title: item['fields']['title'] as String,
              confId: item['fields']['confId'] as String,
              type: item['fields']['type'] as String,
              category: item['fields']['category'] as String,
              shortDescription: item['fields']['shortDescription'] as String,
              description: item['fields']['description'] as String,
              startDate: item['fields']['startDate'] as String,
              endDate: item['fields']['endDate'] as String,
              speaker: Speaker(
                name: item['fields']['name'] as String,
                confIds: item['fields']['confIds'] as String,
                role: item['fields']['role'] as String,
                bio: item['fields']['bio'] as String,
                photoFileUrl: item['fields']['photoFileUrl'] as String,
                photoTitle: item['fields']['photoTitle'] as String,
                photoDescription: item['fields']['photoDescription'] as String,
                email: item['fields']['email'] as String,
                urlGithub: item['fields']['urlGithub'] as String,
                urlLinkedIn: item['fields']['urlLinkedIn'] as String,
                urlTwitter: item['fields']['urlTwitter'] as String,
                urlWww: item['fields']['urlWww'] as String,
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

  Future<void> getSimpleContentById({
    String myId,
    String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _clear(eventContentTypes: EventContentTypes.SIMPLE_CONTENT);
    }

    if (_simpleContent.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.SIMPLE_CONTENT,
            ),
            fields: ['myId=$myId', 'confId=$confId'],
          ));

      try {
        dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (final dynamic item in dataDecode['items']) {
          _simpleContent.putIfAbsent(
            myId,
            () => SimpleContent(
              myId: item['fields']['myId'] as String,
              title: item['fields']['title'] as String,
              text: item['fields']['text'] as String,
              confId: item['fields']['confId'] as String,
            ),
          );
        }

        notifyListeners();
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> getWorkshops({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _clear(eventContentTypes: EventContentTypes.WORKSHOP);
    }

    if (_workShopItems.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.WORKSHOP,
            ),
            fields: ['confId=$confId'],
            order: 'sys.createdAt',
            limit: howMany.toString(),
          ));

      try {
        dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (final dynamic item in dataDecode['items']) {
          _workShopItems.add(
            WorkShop(
              title: item['fields']['title'] as String,
              confId: item['fields']['confId'] as String,
              description: item['fields']['description'] as String,
              speaker: Speaker(
                name: item['fields']['name'] as String,
                confIds: item['fields']['confIds'] as String,
                role: item['fields']['role'] as String,
                bio: item['fields']['bio'] as String,
                photoFileUrl: item['fields']['photoFileUrl'] as String,
                photoTitle: item['fields']['photoTitle'] as String,
                photoDescription: item['fields']['photoDescription'] as String,
                email: item['fields']['email'] as String,
                urlGithub: item['fields']['urlGithub'] as String,
                urlLinkedIn: item['fields']['urlLinkedIn'] as String,
                urlTwitter: item['fields']['urlTwitter'] as String,
                urlWww: item['fields']['urlWww'] as String,
              ),
              startDate: item['fields']['startDate'] as String,
              endDate: item['fields']['endDate'] as String,
              locationDescription:
                  item['fields']['locationDescription'] as String,
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

  Future<void> getSpeakers({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    if (refresh) {
      _clear(eventContentTypes: EventContentTypes.SPEAKER);
    }

    if (_speakers.isEmpty) {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.SPEAKER,
            ),
            fields: ['confIds=$confId'],
            order: 'fields.name',
            limit: howMany.toString(),
          ));

      try {
        dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

        for (final dynamic item in dataDecode['items']) {
          _speakers.add(
            Speaker(
              name: item['fields']['name'] as String,
              confIds: item['fields']['confIds'].toString(),
              role: item['fields']['role'] as String,
              bio: item['fields']['bio'] as String,
              photoFileUrl: item['fields']['photoFileUrl'] as String,
              photoTitle: item['fields']['photoTitle'] as String,
              photoDescription: item['fields']['photoDescription'] as String,
              email: item['fields']['email'] as String,
              urlGithub: item['fields']['urlGithub'] as String,
              urlLinkedIn: item['fields']['urlLinkedIn'] as String,
              urlTwitter: item['fields']['urlTwitter'] as String,
              urlWww: item['fields']['urlWww'] as String,
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
