import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooadmin/Provider/CategoryProvider.dart';
import 'package:wooadmin/Provider/Loading.dart';
import 'package:wooadmin/Provider/SearchProvider.dart';
import 'package:wooadmin/services/Stroage.dart';
import 'package:wooadmin/utils/ProgressHUD.dart';

class BasePage extends StatefulWidget {
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  String title = "";
  @override
  Widget build(BuildContext context) {
    return GetX<LoadingController>(builder: (loading) {
      return Scaffold(
        appBar: _appBar(),
        body: ProgressHUD(
          inAsyncCall: loading.getIsApiCall,
          child: pageUi(),
        ),
      );
    });
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(title),
      elevation: 0,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          onPressed: () {
            Stroage.logout();
          },
          icon: Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget pageUi() {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
