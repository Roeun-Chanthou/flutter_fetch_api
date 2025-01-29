import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/model/product_res_model.dart';

import '../pages/home_page/detail_screen.dart';

class ProductShow extends StatefulWidget {
  const ProductShow({
    super.key,
    required this.item,
  });

  final ProductDb item;

  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item: widget.item,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Hero(
                    tag: widget.item.image,
                    child: Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      widget.item.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.item.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.item.price.toString()}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
