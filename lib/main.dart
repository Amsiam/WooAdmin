import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooadmin/pages/Home_Page.dart';
import 'package:wooadmin/pages/Login_Page.dart';
import 'package:wooadmin/services/Stroage.dart';

Widget _defaultHome = LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _res = await Stroage.isLoggedIn();
  if (_res) {
    _defaultHome = HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: Colors.teal),
      home: _defaultHome,
    );
  }
}
