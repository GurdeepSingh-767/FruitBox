import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:fruitbox_delivery/screens/settings.dart';
import 'package:fruitbox_delivery/screens/user_details.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';
import 'package:fruitbox_delivery/screens/order_screen.dart';

import 'earningsScreen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    return Drawer(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('drivers').doc(userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Showing loading indicator while fetching data
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final Map<String, dynamic> data = (snapshot.data?.data() as Map<String, dynamic>) ?? {}; // Cast to Map<String, dynamic>

          final String displayName = data['name'] ?? 'John Maxwell'; // Default name if not found
          final String userEmail = data['email'] ?? 'johnmaxwell1234@email.com'; // Default email if not found

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  displayName,
                  style: const TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  userEmail,
                  style: const TextStyle(color: Colors.black),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/deliveryimg.png"),
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC201),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHome()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outlined),
                title: const Text("My Profile"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text("Orders"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text("Earnings"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyEarnings()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
