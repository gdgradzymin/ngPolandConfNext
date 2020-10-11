import 'dart:convert';
import 'dart:io';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<InfoItem> _infoItems = [];

    try {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.INFO_ITEM,
            ),
            fields: ['confId=$confId'],
            order: 'fields.order',
            limit: howMany.toString(),
          ));

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
      prefs.setStringList(
        'InfoItems',
        _infoItems.map((InfoItem infoItem) => jsonEncode(infoItem)).toList(),
      );
    } on SocketException {
      if (prefs.containsKey('InfoItems')) {
        List<String> _data = prefs.getStringList('InfoItems');

        _infoItems = _data
            .map(
                (e) => InfoItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
            .toList();
      }

      print('Internet connection lost.');
    } on HttpException {
      print('Couldn\'t find the post.');
    } on FormatException {
      print('Bad response format.');
    }
    return _infoItems;
  }

  Future<List<EventItem>> getEventItems({
    int howMany,
    EventItemType type,
    String confId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<EventItem> _eventItems = [];

    try {
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

      prefs.setStringList(
        'EventItems-$type',
        _eventItems
            .map((EventItem eventItem) => jsonEncode(eventItem))
            .toList(),
      );
    } on SocketException {
      if (prefs.containsKey('EventItems-$type')) {
        List<String> _data = prefs.getStringList('EventItems-$type');

        _eventItems = _data
            .map((e) =>
                EventItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
            .toList();
      }
      throw Failure(
        fail: 'Internet connection lost.',
        localdata: _eventItems,
      );
    } on HttpException {
      print('Couldn\'t find the post.');
    } on FormatException {
      print('Bad response format.');
    } catch (err) {
      print('cos');
    }

    return _eventItems;
  }

  Future<SimpleContent> getSimpleContentById({
    String myId,
    String confId,
    bool refresh = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    SimpleContent _simpleContent;

    try {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.SIMPLE_CONTENT,
            ),
            fields: ['myId=$myId', 'confId=$confId'],
          ));

      dynamic dataDecode = jsonDecode(utf8.decode(response.bodyBytes));

      _simpleContent = SimpleContent(
        myId: dataDecode['items'][0]['fields']['myId'] as String,
        title: dataDecode['items'][0]['fields']['title'] as String,
        text: dataDecode['items'][0]['fields']['text'] as String,
        confId: dataDecode['items'][0]['fields']['confId'] as String,
      );
      prefs.setString(
        'SimpleContent-$myId',
        jsonEncode(_simpleContent),
      );
    } on SocketException {
      if (prefs.containsKey('SimpleContent-$myId')) {
        _simpleContent = SimpleContent.fromJson(
          jsonDecode(
            prefs.getString('SimpleContent-$myId'),
          ) as Map<String, dynamic>,
        );
      }
      print('Internet connection lost.');
    } on HttpException {
      print('Couldn\'t find the post.');
    } on FormatException {
      print('Bad response format.');
    }

    return _simpleContent;
  }

  Future<List<WorkShop>> getWorkshops({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<WorkShop> _workShops = [];

    try {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.WORKSHOP,
            ),
            fields: ['confId=$confId'],
            order: 'sys.createdAt',
            limit: howMany.toString(),
          ));

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
      prefs.setStringList(
        'WorkShop',
        _workShops.map((WorkShop workShop) => jsonEncode(workShop)).toList(),
      );
    } on SocketException {
      if (prefs.containsKey('WorkShop')) {
        List<String> _data = prefs.getStringList('WorkShop');

        _workShops = _data
            .map(
                (e) => WorkShop.fromJson(jsonDecode(e) as Map<String, dynamic>))
            .toList();
      }
      print('Internet connection lost.');
    } on HttpException {
      print('Couldn\'t find the post.');
    } on FormatException {
      print('Bad response format.');
    }

    return _workShops;
  }

  Future<List<Speaker>> getSpeakers({
    int howMany,
    String confId,
    bool refresh = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Speaker> _speakers = [];

    try {
      http.Response response = await http.get(_contentfulEntries +
          _contentfull(
            contentType: getStringFromEventContentTypes(
              EventContentTypes.SPEAKER,
            ),
            fields: ['confIds=$confId'],
            order: 'fields.name',
            limit: howMany.toString(),
          ));

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
      prefs.setStringList(
        'Speakers',
        _speakers.map((Speaker speaker) => jsonEncode(speaker)).toList(),
      );
    } on SocketException {
      if (prefs.containsKey('Speakers')) {
        List<String> _data = prefs.getStringList('Speakers');

        _speakers = _data
            .map((e) => Speaker.fromJson(jsonDecode(e) as Map<String, dynamic>))
            .toList();
      }

      print('Internet connection lost.');
    } on HttpException {
      print('Couldn\'t find the post.');
    } on FormatException {
      print('Bad response format.');
    }

    return _speakers;
  }
}

class Failure {
  Failure({
    this.fail,
    this.localdata,
  });

  final String fail;
  final dynamic localdata;

  @override
  String toString() {
    fail.toString();
    return super.toString();
  }
}
