import 'package:flutter/material.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  @override
  _ChangePhoneNumberScreenState createState() => _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  String newPhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'New Phone Number'),
              onChanged: (value) {
                setState(() {
                  newPhoneNumber = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to update the phone number in your data store.
                // You can use the "newPhoneNumber" variable to get the new phone number.
                // After updating the phone number, you can return to the previous screen.
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
