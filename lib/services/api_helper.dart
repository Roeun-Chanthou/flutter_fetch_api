import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/model/product_res_model.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

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
}
