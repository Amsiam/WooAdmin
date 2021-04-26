import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooadmin/models/login_model.dart';
import 'package:wooadmin/pages/Login_Page.dart';

class Stroage {
  static Future<void> setLoginDetails(LoginModel? loginModel) async {
    var pref = await SharedPreferences.getInstance();

    pref.setString(
        "login_details", loginModel != null ? jsonEncode(loginModel) : "null");
  }

  static Future<LoginModel?> getLoginDetails() async {
    var pref = await SharedPreferences.getInstance();

    return (pref.getString("login_details") != null &&
            pref.getString("login_details") != "null")
        ? LoginModel.fromJson(jsonDecode(pref.getString("login_details")!))
        : null;
  }

  static Future<bool> isLoggedIn() async {
    var pref = await SharedPreferences.getInstance();

    return (pref.getString("login_details") != null &&
            pref.getString("login_details") != "null")
        ? true
        : false;
  }

  static Future<void> logout() async {
    await setLoginDetails(null);
    Get.offAll(() => LoginPage());
  }
}
