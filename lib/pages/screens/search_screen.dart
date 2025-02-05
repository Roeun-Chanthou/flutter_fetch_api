import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/model/product_res_model.dart';
import 'package:flutter_fetch_api/services/api_helper.dart';
import 'package:flutter_fetch_api/widgets/product_show.dart';

class SearchScreenProduct extends StatefulWidget {
  const SearchScreenProduct({super.key});

  @override
  State<SearchScreenProduct> createState() => _SearchScreenProductState();
}

class _SearchScreenProductState extends State<SearchScreenProduct> {
  late Future<List<ProductDb>> _fetchProduct;
  List<ProductDb> _allProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProduct = APIHelper.getProduct(context);
    _fetchProduct.then((products) {
      setState(() {
        _allProducts = products;
      });
    });
  }

  void _searchProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _fetchProduct = Future.value(_allProducts);
      } else {
        _fetchProduct = Future.value(
          _allProducts
              .where((product) =>
                  product.title.toLowerCase().contains(query.toLowerCase()))
              .toList(),
        );
      }
    });
  }

  void _resetSearch() {
    _searchController.clear();
    _searchProducts('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Product by Title',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _resetSearch,
            ),
          ),
          onChanged: _searchProducts,
        ),
      ),
      body: FutureBuilder<List<ProductDb>>(
        future: _fetchProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          List<ProductDb> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              var item = products[index];
              return ProductShow(item: item);
            },
          );
        },
      ),
    );
  }
}
