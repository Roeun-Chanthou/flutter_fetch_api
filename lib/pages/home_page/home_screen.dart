import 'package:flutter/material.dart';
import 'package:flutter_fetch_api/model/product_res_model.dart';
import 'package:flutter_fetch_api/services/api_helper.dart';
import 'package:flutter_fetch_api/widgets/product_show.dart';
import 'package:flutter_fetch_api/widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductDb>> _fetchProduct;

  @override
  void initState() {
    super.initState();
    _fetchProduct = APIHelper.getProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<ProductDb>>(
        future: _fetchProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildListBody(snapshot);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          } else {
            return Center(
              child: Text('State: ${snapshot.connectionState}'),
            );
          }
        },
      ),
    );
  }

  Widget _buildListBody(AsyncSnapshot<List<ProductDb>> snapshot) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: BuildSlider(),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var item = snapshot.data![index];
                return ProductShow(
                  item: item,
                );
              },
              childCount: snapshot.data!.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade200,
      forceMaterialTransparency: true,
      forceElevated: true,
      floating: false,
      pinned: true,
      excludeHeaderSemantics: true,
      flexibleSpace: Container(
        color: Colors.grey.shade200,
      ),
      title: Text(
        "Home Screen",
      ),
    );
  }
}
