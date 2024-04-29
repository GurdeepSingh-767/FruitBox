import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BottomNavBar.dart';
import 'config.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String verify = "";
  static String phoneNumber = "";
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController otpController = TextEditingController(); // Added for OTP entry
  var phone = "";

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/images/deliveryimg.png',
                      width: screenSize.width * 0.8,
                      height: screenSize.width * 0.8,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Get Started with FruitBox',
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your mobile number',
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countrycode,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(' |', style: TextStyle(fontSize: 35, color: Colors.black),),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Phone"
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: countrycode.text + phone,
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Register.verify = verificationId;
                            Register.phoneNumber = countrycode.text + phone;
                            Navigator.pushNamed(context, "authotp");
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                      child: Text(
                        "Send The Code",
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
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
    );
  }
}
