import 'package:get/get_state_manager/get_state_manager.dart';

class SortModel {
  int? columnIndex;
  String? currentcolumnName;
  bool? sortAscending;

  SortModel({
    this.columnIndex,
    this.currentcolumnName,
    this.sortAscending,
  });
}

class SearchController extends GetxController {
  SortModel? _sortModel;
  SortModel? get sortModel => _sortModel;
  SearchController() {
    _sortModel = new SortModel();
    _sortModel!.columnIndex = 0;
    _sortModel!.sortAscending = true;
  }

  setSort(columnIndex, currentcolumnName, sortAscending) {
    _sortModel!.columnIndex = columnIndex;
    _sortModel!.currentcolumnName = currentcolumnName;
    _sortModel!.sortAscending = sortAscending;
    update();
  }
}
