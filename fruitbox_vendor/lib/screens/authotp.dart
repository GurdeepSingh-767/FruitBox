import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'login.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = '';

  void navigateToNextScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MyLogin();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Image.asset(
                  'assets/images/vendorimage.jpg',
                  width: screenSize.width * 0.8,
                  height: screenSize.width * 0.8,
                ),
              ),
              Text(
                'Verify Yourself',
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.width * 0.02),
              Text(
                'Enter the OTP sent',
                style: TextStyle(
                  fontSize: screenSize.width * 0.02,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.width * 0.04),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenSize.width * 0.02,
              ),
              SizedBox(
                height: screenSize.width * 0.09,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print("Entered OTP: $code"); // Debug: Print the entered OTP
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: MyLogin.verify,
                        smsCode: code,
                      );
                      await auth.signInWithCredential(credential);
                      User? user = auth.currentUser;
                      if (user != null) {
                        // Save user information to Firestore under the "vendors" collection
                        DocumentReference userDoc = FirebaseFirestore.instance
                            .collection('vendors')
                            .doc(user.uid);
                        userDoc.set({
                          'address': '', // Add the address field
                          'contact': user.phoneNumber, // Save the phone number as contact
                          'email': '', // Initialize email as empty
                          'name': '', // Initialize name as empty
                        }, SetOptions(merge: true));

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'create_profile',
                              (route) => false,
                        );
                      }
                    } catch (e) {
                      print("Error during authentication: $e");
                      // Handle specific error cases (e.g., incorrect OTP, network issues)
                      // Provide user feedback such as a SnackBar or an alert dialog
                      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
                        print("Invalid OTP provided");
                        // Show an alert to the user that the OTP is invalid
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("The OTP is incorrect. Please try again."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Verify Phone Number'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 196, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: navigateToNextScreen,
                      child: const Text(
                        'Edit Phone number?',
                        style: TextStyle(color: Colors.black),
                      ),
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
