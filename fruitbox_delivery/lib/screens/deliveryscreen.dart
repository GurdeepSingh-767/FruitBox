import 'package:flutter/material.dart';
import 'package:fruitbox_delivery/screens/create_profile.dart';
import 'package:fruitbox_delivery/screens/earningsScreen.dart';
import 'package:fruitbox_delivery/screens/pick_order.dart';
//import 'package:fruitbox_delivery/screens/deliveryscreen.dart';
import 'package:fruitbox_delivery/screens/settings.dart';
import 'package:fruitbox_delivery/screens/user_details.dart';

import 'home_screen.dart';
import 'order_history.dart';
import 'order_screen.dart';

class Delivery_Screen extends StatefulWidget {
  const Delivery_Screen({Key? key}) : super(key: key);

  @override
  State<Delivery_Screen> createState() => _Delivery_ScreenState();
}

class _Delivery_ScreenState extends State<Delivery_Screen> {
  int _currentIndex = 1;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Order accepted successfully',
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
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
            ),
          ),
          Center(
            child: Text(
              'Order Id: 1',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Center(
            child: Text(
              'Vendor Details:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 100,),
              Container(
                width: null,
                child: Center(
                  child: Text(
                    'Name:',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: null,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Alex Pears',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 100,),
              Container(
                width: null,
                child: Center(
                  child: Text(
                    'Phone:',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: null,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '0731456456',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 100,),
              Container(
                width: null,
                child: Center(
                  child: Text(
                    'Vendor Address: ',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10, width: 100,),
          Container(
            child: Center(
              child: Text(
                'Shop no. 55, Sabji Mandi, Nandlalpura, Indore, Madhya Pradesh 452007',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
      // Positioned button at the bottom
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Handle button tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                Pick_OrderFromVendor()),
              );
              // You can navigate to a different screen, show a dialog, etc.
              print('Start Delivery Button Tapped');
            },
            backgroundColor: Color(0xFFFFC201),
            label: Text(
              'Start Delivery',
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
