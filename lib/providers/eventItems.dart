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

  List<EventItem> get eventItems {
    if (_selectedItems == EventItemType.NGPOLAND) {
      return [..._ngPoland];
    } else {
      return [..._jsPoland];
    }
  }

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    bool reload = false,
  }) async {
    _ngPoland = await _contentfulService.getEventItems(
      howMany: howMany,
      type: EventItemType.NGPOLAND,
      reload: reload,
    );

    _jsPoland = await _contentfulService.getEventItems(
      howMany: howMany,
      type: EventItemType.JSPOLAND,
      reload: reload,
    );
    notifyListeners();
  }
}
