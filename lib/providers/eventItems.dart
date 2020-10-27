import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class EventItemsProvider with ChangeNotifier {
  EventItemType _selectedItems = EventItemType.NGPOLAND;

  List<EventItem> _ngPoland = [];

  List<EventItem> _jsPoland = [];

  bool _loadedNgPoland = false;

  bool _loadedJsPoland = false;

  EventItemType get selectedItems => _selectedItems;

  set selectedItems(EventItemType val) {
    _selectedItems = val;

    notifyListeners();
  }

  List<EventItem> get eventItems => _selectedItems == EventItemType.NGPOLAND
      ? _loadedNgPoland && _ngPoland.isEmpty
          ? null
          : _ngPoland
      : _loadedJsPoland && _jsPoland.isEmpty
          ? null
          : _jsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      if (_selectedItems == EventItemType.NGPOLAND && _ngPoland.isNotEmpty) {
        clear(_selectedItems);
      } else if (_selectedItems == EventItemType.JSPOLAND &&
          _jsPoland.isNotEmpty) {
        clear(_selectedItems);
      }

      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );

        _loadedNgPoland = true;
      } else {
        _jsPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );

        _loadedJsPoland = true;
      }
    } catch (err) {
      var _err = err as Failure;

      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = _err.localdata as List<EventItem>;

        _loadedNgPoland = true;
      } else {
        _jsPoland = _err.localdata as List<EventItem>;

        _loadedJsPoland = true;
      }

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear(EventItemType type) {
    if (type == EventItemType.NGPOLAND) {
      _ngPoland = [];

      _loadedNgPoland = false;
    } else {
      _jsPoland = [];

      _loadedJsPoland = false;
    }

    notifyListeners();
  }
}
