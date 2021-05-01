import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wooadmin/models/Category.dart';
import 'package:wooadmin/services/api_service.dart';

class CategoryController extends GetxController {
  CategoryController() {
    this.fetchCategory();
  }
  late APIService _apiService;
  var _categorylist = <Category>[].obs;
  List<Category> get getCateory => _categorylist;
  double get totalRecord => _categorylist.length.toDouble();

  fetchCategory({strSearch, sortBy, sortOrder}) async {
    _apiService = new APIService();
    List<Category>? categories = await _apiService.getCategory(
      strSearch: strSearch,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
    if (categories != null && categories.length > 0)
      _categorylist.addAll(categories);
    //print(categorylist);
  }

  resetSt() {
    _apiService = new APIService();
    _categorylist.value = [];
  }

  createCat(
    Category category,
    Function onCallBack,
  ) async {
    Category? _category = await _apiService.createCat(category);
    if (_category != null) {
      _categorylist.add(_category);
      onCallBack(true);
    } else {
      onCallBack(false);
    }
  }

  updateCat(
    Category category,
    Function onCallBack,
  ) async {
    Category? _category = await _apiService.updateCat(category);
    if (_category != null) {
      _categorylist.remove(category);
      _categorylist.add(_category);
      onCallBack(true);
    } else {
      onCallBack(false);
    }
  }

  delCat(
    Category category,
    Function onCallBack,
  ) async {
    bool _category = await _apiService.delCat(category);
    if (_category) {
      _categorylist.remove(category);
      onCallBack(true);
    } else {
      onCallBack(false);
    }
  }
}
