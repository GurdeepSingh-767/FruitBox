import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Form state and user inputs
  String name = '';
  String email = '';
  String workLocation = '';
  String selectedVehicle = 'Bike';
  String selectedWorkTiming = 'Full Time';
  bool isEmailVerified = false;

  List<String> vehicleOptions = ['Bike', 'EV', 'Cycle', 'Other'];
  List<String> workTimingOptions = ['Full Time', 'Part Time', 'Weekends Only'];

  // Save profile information to Firestore
  Future<void> saveProfile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Reference to the "drivers" collection in Firestore
      CollectionReference drivers = FirebaseFirestore.instance.collection('drivers');

      // Save driver details
      await drivers.doc(userId).set({
        'name': name,
        'email': email,
        'contactNo': FirebaseAuth.instance.currentUser?.phoneNumber,
        'workLocation': workLocation,
        'selectedVehicle': selectedVehicle,
        'selectedWorkTiming': selectedWorkTiming,
        // Add other fields as needed
      });

      if (!isEmailVerified) {
        await sendVerificationEmail();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
      );
    } catch (e) {
      print('Error saving profile: $e');
      // Handle error accordingly, e.g. show an error message
    }
  }

  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification email sent! Please check your email to verify.'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          isEmailVerified = true;
        });
      } catch (e) {
        print('Error sending verification email: $e');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   // SnackBar(
        //   //   content: Text('Failed to send verification email. Please try again.'),
        //   //   backgroundColor: Colors.red,
        //   // ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC201),
        title: const Text(
          'Get On Board!!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenWidth * 0.1),
            Text(
              'Create your profile',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            // Name input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: screenWidth * 0.05),
            // Email input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              // Add email validation here
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: screenWidth * 0.05),
            // Work location input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Work Location',
              ),
              onChanged: (value) {
                workLocation = value;
              },
            ),
            SizedBox(height: screenWidth * 0.05),
            // Vehicle selection
            DropdownButtonFormField<String>(
              value: selectedVehicle,
              decoration: const InputDecoration(
                labelText: 'Select Vehicle',
              ),
              items: vehicleOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVehicle = value!;
                });
              },
            ),
            SizedBox(height: screenWidth * 0.05),
            // Work timing selection
            DropdownButtonFormField<String>(
              value: selectedWorkTiming,
              decoration: const InputDecoration(
                labelText: 'Work Timing',
              ),
              items: workTimingOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedWorkTiming = value!;
                });
              },
            ),
            SizedBox(height: screenWidth * 0.05),
            // Submit button
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC201),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
