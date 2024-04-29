
import 'package:flutter/material.dart';
import '../../user/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final UserOrder order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
    );
  }
}
