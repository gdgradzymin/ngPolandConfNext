import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class WorkshopsProvider with ChangeNotifier {
  EventItemType _selectedItems = EventItemType.NGPOLAND;
  List<Workshop> _workshopItemsNgPoland = [];
  List<Workshop> _workshopItemsJsPoland = [];
  EventItemType get selectedItems => _selectedItems;

  set selectedItems(EventItemType val) {
    _selectedItems = val;
    notifyListeners();
  }

  List<Workshop> get workshopItems {
    if (_selectedItems == EventItemType.NGPOLAND) {
      return [..._workshopItemsNgPoland];
    } else {
      return [..._workshopItemsJsPoland];
    }
  }

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    bool reload = false,
  }) async {
    _workshopItemsNgPoland = await _contentfulService.getWorkshops(
      howMany: howMany,
      type: EventItemType.NGPOLAND,
      reload: reload,
    );

    _workshopItemsJsPoland = await _contentfulService.getWorkshops(
      howMany: howMany,
      type: EventItemType.JSPOLAND,
      reload: reload,
    );

    notifyListeners();
  }
}
