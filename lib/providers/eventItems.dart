import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class EventItemsProvider with ChangeNotifier {
  List<EventItem> _eventItems = [];

  List<EventItem> get eventItems => _eventItems;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
    @required EventItemType type,
    bool refresh = false,
  }) async {
    if (refresh) {
      clear();
    }

    _eventItems = await _contentfulService.getEventItems(
      howMany: howMany,
      type: type,
      confId: confId,
      refresh: refresh,
    ) as List<EventItem>;

    notifyListeners();
  }

  void clear() {
    _eventItems = [];
    notifyListeners();
  }
}
