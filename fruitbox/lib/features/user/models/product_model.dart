import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String categoryName;
  final String description;
  final String imageUrl;
  final String name;
  final String price;

  Product({
    required this.productId,
    required this.categoryName,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
  static Product fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Product(
      productId: snapshot.id,
      categoryName: data['categoryName'] as String,
      name: data['name'] as String,
      price: data['price'] as String,
      imageUrl: data['imageUrl'] as String,
      description: data['description'] as String,
    );
  }
}
