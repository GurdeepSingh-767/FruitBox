import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/authotp.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late TextEditingController phoneNumberController;
  TextEditingController countrycode = TextEditingController();
  var phone = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumberError;

  @override
  void initState() {
    super.initState();
    countrycode.text = "+91";
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // phoneNumberController.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    // Use Navigator to push the next screen (replace 'NextScreen' with your actual screen)
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const MyOtp();
      }),
    );
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!value.startsWith('9') && !value.startsWith('8') && !value.startsWith('7') && !value.startsWith('6')) {
      return 'Invalid phone number';
    }
    return null; // Return null if the validation passes.
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                'Get Started with FruitBox',
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.width * 0.02),
              Text(
                'We need to register your phone before getting started!!',
                style: TextStyle(
                  fontSize: screenSize.width * 0.035,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.width * 0.04),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: screenSize.width * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: screenSize.width * 0.02),
                          SizedBox(
                            width: screenSize.width * 0.1,
                            child: TextFormField(
                              controller: countrycode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            " | ",
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                phone = value;
                                setState(() {
                                  phoneNumberError = validatePhoneNumber(value);
                                });
                              },
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (phoneNumberError != null) // Show the error message if not null
                      Text(
                        phoneNumberError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: screenSize.width * 0.035,
                        ),
                      ),
                    SizedBox(height: screenSize.width * 0.02),
                    SizedBox(
                      height: screenSize.width * 0.09,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print('Phone number: ${countrycode.text + phone}');
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${countrycode.text + phone}',
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent: (String verificationId, int? resendToken) {
                                MyLogin.verify = verificationId;
                                navigateToNextScreen();
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          }
                        },
                        child: const Text('Send OTP'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 196, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
