import 'package:flutter/material.dart';
import 'package:fruitbox_delivery/screens/earningsScreen.dart';
import 'package:fruitbox_delivery/screens/settings.dart';
import 'package:fruitbox_delivery/screens/user_details.dart';

import 'home_screen.dart';
import 'order_history.dart';
import 'order_screen.dart';

class Pick_OrderFromVendor extends StatefulWidget {
  const Pick_OrderFromVendor({super.key});

  @override
  State<Pick_OrderFromVendor> createState() => _Pick_OrderFromVendorState();
}

class _Pick_OrderFromVendorState extends State<Pick_OrderFromVendor> {
  int _currentIndex = 1;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Pickup Order From Shop',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFFC201),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset(
              'assets/images/deliveryimg02.png',
              width: screenWidth * 0.80,
              height: screenWidth * 0.80,
            ),
          ),
          ],),
      // Positioned button at the bottom
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Handle button tap

              // You can navigate to a different screen, show a dialog, etc.
              print('Start Delivery Button Tapped');
            },
            backgroundColor: Color(0xFFFFC201),
            label: Text(
              'Order Picked Up',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFC201),
        selectedItemColor: Colors.black, // Color of the active item
        unselectedItemColor: Colors.grey, // Color of inactive items
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle tapping on navigation items
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
            // You can push the home page or use your navigation logic
          } else if (index == 1) {
            // Handle other navigation items
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyEarnings()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailsScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined), // Use outlined version
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee_rounded), // Use outlined version
            label: 'My Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), // Use outlined version
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

