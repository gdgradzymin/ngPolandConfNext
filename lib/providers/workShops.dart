import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ng_poland_conf_next/models/contentful.dart';
import 'package:ng_poland_conf_next/services/contentful.dart';

class WorkshopsProvider with ChangeNotifier {
  EventItemType _selectedItems;

  List<Workshop> _workshopItemsngPoland = [];

  List<Workshop> _workshopItemsjsPoland = [];

  List<Workshop> get workshopItems => _selectedItems == EventItemType.NGPOLAND
      ? _workshopItemsngPoland
      : _workshopItemsjsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required EventItemType type,
    @required String confId,
  }) async {
    try {
      if (type == EventItemType.NGPOLAND) {
        _selectedItems = EventItemType.NGPOLAND;
        _workshopItemsngPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: type,
          confId: confId,
        );
      } else {
        _selectedItems = EventItemType.JSPOLAND;
        _workshopItemsjsPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: type,
          confId: confId,
        );
      }
    } catch (err) {
      var _err = err as Failure;

      if (type == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = _err.localdata as List<Workshop>;
      } else {
        _workshopItemsjsPoland = _err.localdata as List<Workshop>;
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
        _selectedItems = EventItemType.NGPOLAND;
        _workshopItemsngPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      } else {
        _selectedItems = EventItemType.JSPOLAND;
        _workshopItemsjsPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      }
    } catch (err) {
      var _err = err as Failure;

      if (_selectedItems == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = _err.localdata as List<Workshop>;
      } else {
        _workshopItemsjsPoland = _err.localdata as List<Workshop>;
      }

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear(EventItemType type) {
    if (type == EventItemType.NGPOLAND) {
      _workshopItemsngPoland = [];
    } else {
      _workshopItemsjsPoland = [];
    }

    notifyListeners();
  }
}
