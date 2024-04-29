

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/create_profile.dart';
import 'package:fruitbox_vendor/screens/home.dart';
import 'screens/login.dart';
import 'screens/authotp.dart';


void main()  async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: API_KEY,
      appId: "1:573217921792:android:8664debd56d04a562af1e5",
      messagingSenderId: MESSAGE_ID,
      projectId: "fruitbox-4bb62",
      storageBucket: STROAGE_BUCKET,
    ),
  );


  String phoneNumber= "";
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => const MyLogin(),
      'authotp': (context) => const MyOtp(),
      'home_screen': (context) => MyHome(),
      'create_profile': (context) => Profile(phoneNumber),


    },
  ));
}