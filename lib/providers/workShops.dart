import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ngPolandConf/models/contentful.dart';
import 'package:ngPolandConf/services/contentful.dart';

class WorkshopsProvider with ChangeNotifier {
  EventItemType _selectedItems = EventItemType.NGPOLAND;

  List<Workshop> _workshopItemsngPoland = [];

  List<Workshop> _workshopItemsjsPoland = [];

  bool _loadedNgPoland = false;

  bool _loadedJsPoland = false;

  EventItemType get selectedItems => _selectedItems;

  set selectedItems(EventItemType val) {
    _selectedItems = val;

    notifyListeners();
  }

  List<Workshop> get workshopItems => _selectedItems == EventItemType.NGPOLAND
      ? _loadedNgPoland && _workshopItemsngPoland.isEmpty
          ? null
          : _workshopItemsngPoland
      : _loadedJsPoland && _workshopItemsjsPoland.isEmpty
          ? null
          : _workshopItemsjsPoland;

  final ContentfulService _contentfulService = GetIt.I.get<ContentfulService>();

  Future fetchData({
    @required int howMany,
    @required String confId,
  }) async {
    try {
      if (_selectedItems == EventItemType.NGPOLAND &&
          _workshopItemsngPoland.isNotEmpty) {
        clear(_selectedItems);
      } else if (_selectedItems == EventItemType.JSPOLAND &&
          _workshopItemsjsPoland.isNotEmpty) {
        clear(_selectedItems);
      }

      if (_selectedItems == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );

        _loadedNgPoland = true;
      } else {
        _workshopItemsjsPoland = await _contentfulService.getWorkshops(
          howMany: howMany,
          type: _selectedItems,
          confId: confId,
        );

        _loadedJsPoland = true;
      }
    } catch (err) {
      var _err = err as Failure;

      if (_selectedItems == EventItemType.NGPOLAND) {
        _workshopItemsngPoland = _err.localdata as List<Workshop>;

        _loadedNgPoland = true;
      } else {
        _workshopItemsjsPoland = _err.localdata as List<Workshop>;

        _loadedJsPoland = true;
      }

      notifyListeners();

      throw _err.fail;
    }

    notifyListeners();
  }

  void clear(EventItemType type) {
    if (type == EventItemType.NGPOLAND) {
      _workshopItemsngPoland = [];

      _loadedNgPoland = false;
    } else {
      _workshopItemsjsPoland = [];

      _loadedJsPoland = false;
    }

    notifyListeners();
  }
}
