import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnterUserDetails extends StatefulWidget {
  const EnterUserDetails({super.key});

  @override
  EnterUserDetailsState createState() => EnterUserDetailsState();
}

class EnterUserDetailsState extends State<EnterUserDetails> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = auth.currentUser?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'FruitBox',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            // Welcome text
            const Text(
              'Welcome to FruitBox!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Name input field
            const Text('Please enter your name:'),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await saveUserDetails(nameController.text, phoneNumber);
                Navigator.pushReplacementNamed(context, 'bottomNav');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFFC201),
              ),
              child: const Text('Save Details'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserDetails(
      String name, String phoneNumber) async {
    try {
      await _firestore.collection('users').doc(auth.currentUser!.uid).set({
        'name': name,
        'phoneNumber': phoneNumber,
        'address': ''
      });
    } catch (e) {
      print("Error saving user details: $e");
    }
  }
}
