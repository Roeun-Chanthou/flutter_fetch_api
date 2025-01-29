// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/model/product_res_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.item,
  });

  final ProductDb item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ProductDb product;

  @override
  void initState() {
    product = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          product.title,
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: product.image,
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 400,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "\$${product.price.toString()}",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  " ${product.rating.rate.toString()}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  " (${product.rating.count.toString()} Reviews)",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
