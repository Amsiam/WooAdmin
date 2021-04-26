import 'package:flutter/material.dart';
import 'package:wooadmin/services/Stroage.dart';

class BasePage extends StatefulWidget {
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: pageUi(),
    );
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
