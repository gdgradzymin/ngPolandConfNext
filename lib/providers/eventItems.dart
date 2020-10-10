import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class EventItemsProvider with ChangeNotifier {
  EventItemType _selectedItems;

  List<EventItem> _ngPoland = [];

  List<EventItem> _jsPoland = [];

  List<EventItem> get eventItems =>
      _selectedItems == EventItemType.NGPOLAND ? _ngPoland : _jsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
    @required EventItemType type,
  }) async {
    if (type == EventItemType.NGPOLAND) {
      _selectedItems = EventItemType.NGPOLAND;
      _ngPoland = await _contentfulService.getEventItems(
        howMany: howMany,
        type: type,
        confId: confId,
      );
    } else {
      _selectedItems = EventItemType.JSPOLAND;
      _jsPoland = await _contentfulService.getEventItems(
        howMany: howMany,
        type: type,
        confId: confId,
      );
    }

    notifyListeners();
  }

  Future refreshData({
    @required int howMany,
    @required String confId,
  }) async {
    clear(_selectedItems);

    if (_selectedItems == EventItemType.NGPOLAND) {
      _selectedItems = EventItemType.NGPOLAND;
      _ngPoland = await _contentfulService.getEventItems(
        howMany: howMany,
        type: _selectedItems,
        confId: confId,
      );
    } else {
      _selectedItems = EventItemType.JSPOLAND;
      _jsPoland = await _contentfulService.getEventItems(
        howMany: howMany,
        type: _selectedItems,
        confId: confId,
      );
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
