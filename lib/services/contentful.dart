import 'dart:convert';
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

class ContentfulService {
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

  Future<List<InfoItem>> getInfoItems({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    List<InfoItem> _infoItems = [];

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
    } catch (err) {
      print(err);
    }
    return _infoItems;
  }

  Future<List<EventItem>> getEventItems({
    int howMany,
    EventItemType type,
    String confId,
    bool refresh = false,
  }) async {
    List<EventItem> _eventItems = [];

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
        dynamic _speaker;

        String _photoFileUrl = '';
        if (item['fields']['presenter'] != null) {
          for (final dynamic asset in dataDecode['includes']['Entry']) {
            if (asset['sys']['id'] ==
                item['fields']['presenter']['sys']['id']) {
              _speaker = asset['fields'];
            }
          }

          for (final dynamic asset in dataDecode['includes']['Asset']) {
            if (asset['sys']['id'] == _speaker['photo']['sys']['id']) {
              _photoFileUrl = asset['fields']['file']['url'] as String;
            }
          }
        }

        _eventItems.add(
          EventItem(
            title: item['fields']['title'] as String ?? null,
            confId: item['fields']['confId'] as String ?? null,
            type: item['fields']['type'] as String ?? null,
            category: item['fields']['category'] as String ?? null,
            shortDescription:
                item['fields']['shortDescription'] as String ?? null,
            description: item['fields']['description'] as String ?? null,
            startDate: item['fields']['startDate'] as String ?? null,
            endDate: item['fields']['endDate'] as String ?? null,
            speaker: _speaker == null
                ? null
                : Speaker(
                    name: _speaker['name'] as String,
                    confIds: _speaker['confIds'].toString(),
                    role: _speaker['role'] as String,
                    bio: _speaker['bio'] as String,
                    photoFileUrl: _photoFileUrl,
                    photoTitle: _speaker['photoTitle'] as String,
                    photoDescription: _speaker['photoDescription'] as String,
                    email: _speaker['email'] as String,
                    urlGithub: _speaker['urlGithub'] as String,
                    urlLinkedIn: _speaker['urlLinkedIn'] as String,
                    urlTwitter: _speaker['urlTwitter'] as String,
                    urlWww: _speaker['urlWww'] as String,
                  ),
          ),
        );
      }
    } catch (err) {
      print(err);
    }

    return _eventItems;
  }

  Future<Map<String, SimpleContent>> getSimpleContentById({
    String myId,
    String confId,
    bool refresh = false,
  }) async {
    Map<String, SimpleContent> _simpleContent = {};

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
    } catch (err) {
      print(err);
    }

    return _simpleContent;
  }

  Future<List<WorkShop>> getWorkshops({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    List<WorkShop> _workShops = [];

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
        dynamic _speaker;

        String _photoFileUrl = '';

        for (final dynamic asset in dataDecode['includes']['Entry']) {
          if (asset['sys']['id'] == item['fields']['instructor']['sys']['id']) {
            _speaker = asset['fields'];
          }
        }

        for (final dynamic asset in dataDecode['includes']['Asset']) {
          if (asset['sys']['id'] == _speaker['photo']['sys']['id']) {
            _photoFileUrl = asset['fields']['file']['url'] as String;
          }
        }

        _workShops.add(
          WorkShop(
            title: item['fields']['title'] as String,
            confId: item['fields']['confId'] as String,
            description: item['fields']['description'] as String,
            speaker: Speaker(
              name: _speaker['name'] as String,
              role: _speaker['role'] as String,
              bio: _speaker['bio'] as String,
              photoFileUrl: _photoFileUrl,
              photoTitle: _speaker['photoTitle'] as String,
              photoDescription: _speaker['photoDescription'] as String,
              email: _speaker['email'] as String,
              urlGithub: _speaker['urlGithub'] as String,
              urlLinkedIn: _speaker['urlLinkedIn'] as String,
              urlTwitter: _speaker['urlTwitter'] as String,
              urlWww: _speaker['urlWww'] as String,
            ),
            startDate: item['fields']['startDate'] as String,
            endDate: item['fields']['endDate'] as String,
            locationDescription:
                item['fields']['locationDescription'] as String,
            pricePln: item['fields']['pricePln'].toString(),
          ),
        );
      }
    } catch (err) {
      print(err);
    }

    return _workShops;
  }

  Future<List<Speaker>> getSpeakers({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    List<Speaker> _speakers = [];

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
        String _photoFileUrl = '';
        for (final dynamic asset in dataDecode['includes']['Asset']) {
          if (asset['sys']['id'] == item['fields']['photo']['sys']['id']) {
            _photoFileUrl = asset['fields']['file']['url'] as String;
          }
        }

        _speakers.add(
          Speaker(
            name: item['fields']['name'] as String,
            confIds: item['fields']['confIds'].toString(),
            role: item['fields']['role'] as String,
            bio: item['fields']['bio'] as String,
            photoFileUrl: _photoFileUrl,
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
    } catch (err) {
      print(err);
    }

    return _speakers;
  }
}
