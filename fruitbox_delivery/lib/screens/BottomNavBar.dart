import 'package:flutter/material.dart';
import 'package:fruitbox_delivery/screens/settings.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';
import 'package:fruitbox_delivery/screens/order_screen.dart';
import 'package:fruitbox_delivery/screens/order_history.dart';
import 'package:fruitbox_delivery/screens/earningsScreen.dart';
import 'package:fruitbox_delivery/screens/settings.dart';
import 'package:fruitbox_delivery/screens/user_details.dart';

import 'earningsScreen.dart';
import 'home_screen.dart';
import 'order_history.dart';
import 'order_screen.dart';

import 'package:flutter/material.dart';
import 'package:fruitbox_delivery/screens/home_screen.dart';
import 'package:fruitbox_delivery/screens/order_screen.dart';
import 'package:fruitbox_delivery/screens/earningsScreen.dart';
import 'package:fruitbox_delivery/screens/settings.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const AppBottomNavigationBar({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFFC201),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        handleBottomNavigationTap(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.currency_rupee_rounded),
          label: 'My Earnings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }

  void handleBottomNavigationTap(BuildContext context, int index) {
    // Handle tapping on bottom navigation items
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHome()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyEarnings()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsScreen()),
        );
        break;

    }
  }
}
