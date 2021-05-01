import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoadingController extends GetxController {
  RxBool _isapicall = false.obs;

  bool get getIsApiCall => _isapicall.value;

  setIsApiCall(bool status) {
    _isapicall.value = status;
  }
}
