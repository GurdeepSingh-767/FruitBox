import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fruitbox_delivery/screens/auth_otp.dart';
import 'package:fruitbox_delivery/screens/auth_register.dart';
import 'package:fruitbox_delivery/screens/create_profile.dart';
import 'package:fruitbox_delivery/screens/deliveryscreen.dart';
import 'package:fruitbox_delivery/screens/earningsScreen.dart';
import 'package:fruitbox_delivery/screens/enter_user_details.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';
import 'package:fruitbox_delivery/screens/order_history.dart';
import 'package:fruitbox_delivery/screens/order_screen.dart';
import 'package:fruitbox_delivery/screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: API_KEY,
      appId: "1:573217921792:android:343506b40a02869e2af1e5",
      messagingSenderId: MESSAGE_ID,
      projectId: "fruitbox-4bb62",
      storageBucket: STORAGE_BUCKET,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? 'home_screen' : 'login',
      routes: {
        'login': (context) => const Register(),
        'Profile': (context) => Profile(),
        'authotp': (context) => const OTPScreen(),
        'order_screen': (context) => const OrderScreen(),
        'home_screen': (context) => const MyHome(),
        'deliveryscreen': (context) => const Delivery_Screen(),
        'order_history': (context) => const OrderHistory(),
        'earningsScreen': (context) => const MyEarnings(),
      },
    );
  }
}
