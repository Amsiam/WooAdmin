import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wooadmin/models/Category.dart';
import 'package:wooadmin/models/login_model.dart';
import 'package:wooadmin/services/Stroage.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> checklogin(LoginModel loginModel) async {
    Map<String, String> reqheader = {
      "Content-Type": 'application/json',
    };

    var url = Uri.https(loginModel.host!, "/wp-json/wc/v3/products", {
      "consumer_key": loginModel.consumerKey,
      "consumer_secret": loginModel.consumerSecret
    });

    var response = await client.get(url, headers: reqheader);

    if (response.statusCode == 200) {
      await Stroage.setLoginDetails(loginModel);
      return true;
    }
    return false;
  }

  Future<List<Category>?> getCategory({
    String? strSearch,
    String? sortBy,
    String? sortOrder = "asc",
    bool parentCategory = true,
  }) async {
    Map<String, String> reqheader = {
      "Content-Type": 'application/json',
    };

    var loginModel = await Stroage.getLoginDetails();

    Map<String, String> queryString = {
      "consumer_key": loginModel!.consumerKey!,
      "consumer_secret": loginModel.consumerSecret!
    };
    if (strSearch != null) {
      queryString['search'] = strSearch;
    }
    if (parentCategory) queryString['parent'] = "0";

    if (sortBy != null) queryString['orderby'] = sortBy;
    if (sortOrder != null) queryString['order'] = sortOrder;

    var url = Uri.https(
      loginModel.host!,
      "/wp-json/wc/v3/products/categories",
      queryString,
    );
    var response = await client.get(url, headers: reqheader);
    //print(response);
    if (response.statusCode == 200) {
      return categoriesFromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<Category?> createCat(Category category) async {
    var loginModel = await Stroage.getLoginDetails();
    var authtoken = base64.encode(
      utf8.encode(loginModel!.consumerKey! + ":" + loginModel.consumerSecret!),
    );
    Map<String, String> requestHeader = {
      "Content-Type": 'application/json',
      "authorization": "Basic $authtoken",
    };
    var url = new Uri.https(
      loginModel.host!,
      "/wp-json/wc/v3/products/categories",
    );
    var response = await client.post(
      url,
      headers: requestHeader,
      body: json.encode(category.toJson()),
    );

    if (response.statusCode == 201) {
      return categoryFromjson(response.body);
    } else
      return null;
  }

  Future<Category?> updateCat(Category category) async {
    var loginModel = await Stroage.getLoginDetails();
    var authtoken = base64.encode(
      utf8.encode(loginModel!.consumerKey! + ":" + loginModel.consumerSecret!),
    );
    Map<String, String> requestHeader = {
      "Content-Type": 'application/json',
      "authorization": "Basic $authtoken",
    };
    var url = new Uri.https(
      loginModel.host!,
      "/wp-json/wc/v3/products/categories/" + category.id.toString(),
    );
    var response = await client.put(
      url,
      headers: requestHeader,
      body: json.encode(category.toJson()),
    );

    if (response.statusCode == 200)
      return categoryFromjson(response.body);
    else
      return null;
  }

  Future<bool> delCat(Category category) async {
    var loginModel = await Stroage.getLoginDetails();
    var authtoken = base64.encode(
      utf8.encode(loginModel!.consumerKey! + ":" + loginModel.consumerSecret!),
    );
    Map<String, String> requestHeader = {
      "authorization": "Basic $authtoken",
    };
    var url = new Uri.https(loginModel.host!,
        "/wp-json/wc/v3/products/categories/" + category.id.toString(), {
      "force": "true",
    });
    var response = await client.delete(
      url,
      headers: requestHeader,
    );

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
