import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooadmin/Provider/CategoryProvider.dart';
import 'package:wooadmin/Provider/Loading.dart';
import 'package:wooadmin/Provider/SearchProvider.dart';
import 'package:wooadmin/models/NavBar.dart';
import 'package:wooadmin/pages/categories/category_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoryController c = Get.put(CategoryController());
  final LoadingController loading = Get.put(LoadingController());
  final SearchController searchController = Get.put(SearchController());
  List<NavBar> _titlelist = [
    NavBar(title: "DashBoard", icon: Icons.home, color: "#00B8E0"),
    NavBar(title: "Categories", icon: Icons.category, color: "#A50606"),
    NavBar(title: "Products", icon: Icons.image, color: "#6D7600"),
    NavBar(title: "Customers", icon: Icons.group, color: "#450FE0"),
    NavBar(title: "Orders", icon: Icons.shopping_basket, color: "#c604ca"),
  ];
  int _index = 0;

  var _widgetlist = [
    Container(),
    CategoryList(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetlist[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            this._index = index;
          });
        },
        items: _titlelist.map(
          (NavBar navBar) {
            return BottomNavigationBarItem(
              icon: Icon(
                navBar.icon,
              ),
              label: "",
              tooltip: navBar.title,
            );
          },
        ).toList(),
        selectedItemColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
