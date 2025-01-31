import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<String>> _fetchCategories;

  @override
  void initState() {
    super.initState();
    _fetchCategories = APIHelper.getProductCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
              );
            },
          );
        },
      ),
    );
  }
}

class APIHelper {
  static Future<List<String>> getProductCategory() async {
    String url = "https://fakestoreapi.com/products/categories";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<String> categories = List<String>.from(data);
        return categories;
      } else {
        throw Exception("Error Code: ${response.statusCode}");
      }
    } catch (e) {
      // Show a more user-friendly error message
      return ["Failed to load categories"];
    }
  }
}
