import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../../user/models/category_model.dart';
import '../../user/models/product_model.dart';
import '../../../common/widget/card.dart';

class SearchResults extends StatelessWidget {
  final List<dynamic> results;

  const SearchResults({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        padding: const EdgeInsets.all(10.0), // Apply padding around the list
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          if (result is Category) {
            return buildCategoryCard(result);
          } else if (result is Product) {
            return buildProductCard(result);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildCategoryCard(Category category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            category.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        FutureBuilder<List<Product>>(
          future: getProductsByCategory(category.name),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Error loading products: ${snapshot.error}'),
              );
            }

            final productList = snapshot.data ?? [];
            if (productList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('No products found under the "${category.name}" category.'),
              );
            }

            // Add padding around each product card
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: buildProductCard(product),
                );
              },
            );
          },
        )
      ],
    );
  }

  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category_name', isEqualTo: categoryName)
        .get();

    final productList = snapshot.docs.map((doc) {
      return Product.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
    }).toList();

    return productList;
  }

  Widget buildProductCard(Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Uniform padding around the card
      child: ProductCard(product: product),
    );
  }
}


class SearchBox extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const SearchBox({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: appPading,
        right: appPading,
        top: appPading,
      ),
      child: Material(
        elevation: 10.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          onChanged: onSearch,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(
              vertical: appPading * 0.75,
              horizontal: appPading,
            ),
            fillColor: Colors.white,
            hintText: 'Find your choice!',
            suffixIcon: Icon(
              Icons.search_rounded,
              size: 30,
              color: GlobalVariables.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
