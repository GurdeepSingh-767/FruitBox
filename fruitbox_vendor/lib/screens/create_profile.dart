import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitbox_vendor/screens/home.dart';


class Profile extends StatefulWidget {
  final String phoneNumber;

  Profile(this.phoneNumber);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String email = '';
  String address = '';

  bool isEditing = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void saveToFirestore() {
    firestore.collection('vendors').add({
      'name': name,
      'email': email,
      'address': address,
      'contact': widget.phoneNumber,
      // Add more fields as needed
    }).then((value) {
      print('Data added to Firestore!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHome(
            name: name,
            email: email,
          ),
        ),
      );
    }).catchError((error) {
      print('Failed to add data to Firestore: $error');
      // Handle error scenarios
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC201),
        title: Text(
          'Create Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Create Vendor Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              onChanged: (value) => setState(() => name = value),
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) => setState(() => email = value),
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) => setState(() => address = value),
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                saveToFirestore(); // Save the data to Firestore
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC201),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
