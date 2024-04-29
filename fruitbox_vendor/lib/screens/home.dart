import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:badges/badges.dart' as custom_badges;
import 'package:fruitbox_vendor/screens/addfruits.dart';
import 'package:fruitbox_vendor/screens/items.dart';
import 'package:fruitbox_vendor/screens/notification.dart';
import 'package:fruitbox_vendor/screens/orders.dart';
import 'package:fruitbox_vendor/screens/profile.dart';
import 'package:fruitbox_vendor/screens/settings.dart';




class MyHome extends StatefulWidget {
  final String? name;
  final String? email;

  MyHome({this.name, this.email});

  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<MyHome> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int notificationCount = 0;
  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;

    // Configure Firebase Messaging
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle incoming messages when the app is in the foreground
      handleNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Handle notification when the app is resumed from a terminated or background state
      handleNotification(message.data);
    });

    // Initialize Firebase Messaging
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Method to handle incoming notification
  void handleNotification(Map<String, dynamic> message) {
    // Increment the notification count
    setState(() {
      notificationCount++;
    });

    // Process other notification data as needed
    // For example, display a notification dialog or navigate to a specific screen
  }

  // Method to mark notification as read
  void markNotificationAsRead() {
    if (notificationCount > 0) {
      setState(() {
        notificationCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String? name = widget.name ?? 'Default Name';
    final String? email = widget.email ?? 'Default Email';

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Vendor App',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFFC201),
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer(); // Open the drawer on tap
          },
          child: Icon(
            Icons.menu, // Hamburger menu icon
            color: Colors.black, // Set the color of the icon
          ),
        ),
        actions: <Widget>[
          custom_badges.Badge(
            position: custom_badges.BadgePosition.topEnd(top: 1, end: 1),
            badgeContent: notificationCount >0
            ? Text(
              '$notificationCount',
              style: TextStyle(color: Colors.white),
            )
            : null,
            child: IconButton(
                onPressed: () {
                  markNotificationAsRead();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notification_View()),
                  );
                },
                icon: Stack(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: Colors.black, // Set the color of the icon
                    ),
                    if(notificationCount>0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$notificationCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ],
                )
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/vendorimage.jpg',
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
            ),
            Text(
              'Welcome to FruitBox !!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Add functionality to list a new item for sale
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemListingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC201),
              ),
              child: Text(
                '+ Add Fruits',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
                'List Your Fruits And Start Selling'), // Display the seller's listed items here
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(name!),
                accountEmail: Text(email!),
                currentAccountPicture: CircleAvatar(
                  // You can set a profile picture here
                  backgroundImage: AssetImage("assets/images/ashish.jpg"),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFC201),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  // Handle tapping on the "Home" item in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHome()),
                  );
                  // You can navigate to the home page or use your logic here
                },
              ),
              ListTile(
                leading: Icon(Icons.person_outlined),
                title: Text("My Profile"),
                onTap: () {
                  // Handle tapping on the "Orders" item in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          vendorName: name ?? '',
                          email: email ?? '',
                        )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.addchart_outlined),
                title: Text("Fruits Listed"),
                onTap: () {
                  // Handle tapping on the "Listed" item in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyItem()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt_outlined),
                title: Text("Orders"),
                onTap: () {
                  // Handle tapping on the "Orders" item in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyOrders()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text("Settings"),
                onTap: () {
                  // Handle tapping on the "Listed" item in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySetting()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFC201),
        selectedItemColor: Colors.black, // Color of the active item
        unselectedItemColor: Colors.grey, // Color of inactive items
        currentIndex: 0,
        onTap: (index) {
          // Handle tapping on navigation items
          if (index == 0) {
            // Navigate to the home page
            // You can push the home page or use your navigation logic
          } else if (index == 1) {
            // Handle other navigation items
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyItem()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyOrders()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySetting()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart_outlined), // Use outlined version
            label: 'Listed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined), // Use outlined version
            label: 'Orders',
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


