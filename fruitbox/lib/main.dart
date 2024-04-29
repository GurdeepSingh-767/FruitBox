import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fruitbox/constants/router.dart' as custom_router;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const firebaseOptions = FirebaseOptions(
      apiKey: API_KEY,
      authDomain:DOMAIN_NAME ,
      databaseURL:
     DATABASE_URL,
      projectId: 'fruitbox-4bb62',
      storageBucket: STROAGE_BUCKET,
      messagingSenderId: MESSAGE_SENDER_ID,
      appId: '1:573217921792:web:1d4922b09de944202af1e5',
      measurementId: MEASUREMENT_ID);
  try {
    await Firebase.initializeApp(options: firebaseOptions);
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? 'bottomNav' : 'register',
      onGenerateRoute: custom_router.Router.generateRoute,
    );
  }
}