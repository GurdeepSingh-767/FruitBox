import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;
  final Function onPaymentConfirmed;

  const PaymentPage({
    super.key,
    required this.totalAmount,
    required this.onPaymentConfirmed,
  });

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final TextEditingController upiIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Payment: Rs. ${widget.totalAmount}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'You are about to make a payment. Please confirm your payment details and proceed.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Note: This is a dummy payment confirmation for testing purposes only.',
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: upiIdController,
              decoration: const InputDecoration(
                labelText: 'Enter UPI ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _confirmPayment(context);
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmPayment(BuildContext context) {
    // Display a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Payment confirmed!')),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ordered!')),
    );
    // Call the callback function to proceed with checkout
    widget.onPaymentConfirmed();

    // Pop context twice to close the PaymentPage and the dialog box
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
