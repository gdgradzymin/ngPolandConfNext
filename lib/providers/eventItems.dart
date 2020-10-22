import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class EventItemsProvider with ChangeNotifier {
  EventItemType _selectedItems = EventItemType.NGPOLAND;

  List<EventItem> _ngPoland = [];

  List<EventItem> _jsPoland = [];

  EventItemType get selectedItems => _selectedItems;

  set selectedItems(EventItemType val) {
    _selectedItems = val;

    notifyListeners();
  }

  List<EventItem> get eventItems =>
      _selectedItems == EventItemType.NGPOLAND ? _ngPoland : _jsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          confId: confId,
          type: _selectedItems,
        );
      } else {
        _jsPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          confId: confId,
          type: _selectedItems,
        );
      }
    } catch (err) {
      var _err = err as Failure;

      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = _err.localdata as List<EventItem>;
      } else {
        _jsPoland = _err.localdata as List<EventItem>;
      }

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  Future refreshData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      clear(_selectedItems);

      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      } else {
        _jsPoland = await _contentfulService.getEventItems(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      }
    } catch (err) {
      var _err = err as Failure;

      if (_selectedItems == EventItemType.NGPOLAND) {
        _ngPoland = _err.localdata as List<EventItem>;
      } else {
        _jsPoland = _err.localdata as List<EventItem>;
      }

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear(EventItemType type) {
    if (type == EventItemType.NGPOLAND) {
      _ngPoland = [];
    } else {
      _jsPoland = [];
    }

    notifyListeners();
  }
}
