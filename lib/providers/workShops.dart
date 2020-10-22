import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class WorkshopsProvider with ChangeNotifier {
  EventItemType _selectedItems = EventItemType.NGPOLAND;

  List<Workshop> _workshopItemsngPoland = [];

  List<Workshop> _workshopItemsjsPoland = [];

  EventItemType get selectedItems => _selectedItems;

  set selectedItems(EventItemType val) {
    _selectedItems = val;

    notifyListeners();
  }

  List<Workshop> get workshopItems => _selectedItems == EventItemType.NGPOLAND
      ? _workshopItemsngPoland
      : _workshopItemsjsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      if (_selectedItems == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      } else {
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

  Future refreshData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      clear(_selectedItems);

      if (_selectedItems == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );
      } else {
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
