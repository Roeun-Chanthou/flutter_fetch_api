import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../model/product_res_model.dart';

class APIHelper {
  static Future<List<ProductDb>> getProduct(BuildContext context) async {
    String url = "https://fakestoreapi.com/products";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      var prodcutData = data.map((e) => ProductDb.fromJson(e)).toList();
      return prodcutData;
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: '${response.statusCode}',
      );
      throw Exception("Error Code: ${response.statusCode}");
    }
  }

  static Future<List<String>> getProductCategory() async {
    String url = "https://fakestoreapi.com/products/categories";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<String> categories =
            data.map<String>((e) => e.toString()).toList();
        return categories;
      } else {
        throw Exception("Error Code: ${response.statusCode}");
      }
    } catch (e) {
      return [
        "Error",
      ];
    }
  }
}
