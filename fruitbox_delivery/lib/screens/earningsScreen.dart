// import 'package:flutter/material.dart';
// import 'package:fruitbox_delivery/screens/settings.dart';
//
// import 'create_profile.dart';
// import 'home_screen.dart';
// import 'order_history.dart';
// import 'order_screen.dart';
//
// class MyEarnings extends StatefulWidget {
//   const MyEarnings({super.key});
//
//   @override
//   State<MyEarnings> createState() => _MyEarningsState();
// }
//
// class _MyEarningsState extends State<MyEarnings> {
//
//   int _currentIndex = 2;
//
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text(
//           'My Earnings',
//           style: TextStyle(
//             fontWeight: FontWeight.w100,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Color(0xFFFFC201),
//         leading: GestureDetector(
//           onTap: () {
//             scaffoldKey.currentState?.openDrawer(); // Open the drawer on tap
//           },
//           child: Icon(
//             Icons.menu, // Hamburger menu icon
//             color: Colors.black, // Set the color of the icon
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: 15,
//           ),
//           Center(
//             child: Image.asset(
//               'assets/images/earningsimg.png',
//               width: screenWidth * 0.4,
//               height: screenWidth * 0.4,
//             ),
//           ),
//           Center(
//             child: Text(
//               'Your Earnings!!',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: Container(
//           decoration: BoxDecoration(),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               UserAccountsDrawerHeader(
//                 accountName: Text(
//                   "John Maxwell",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 accountEmail: Text(
//                   "johnmaxwell1234@email.com",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 currentAccountPicture: CircleAvatar(
//                   // You can set a profile picture here
//                   backgroundImage: AssetImage("assets/images/deliveryimg.png"),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFC201),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 onTap: () {
//                   // Handle tapping on the "Orders" item in the drawer
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyHome()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_outlined),
//                 title: Text("My Profile"),
//                 onTap: () {
//                   // Handle tapping on the "Orders" item in the drawer
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Profile()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.list_alt_outlined),
//                 title: Text("Orders"),
//                 onTap: () {
//                   // Handle tapping on the "Home" item in the drawer
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => OrderScreen()),
//                   );
//                   // You can navigate to the home page or use your logic here
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings_outlined),
//                 title: Text("Settings"),
//                 onTap: () {
//                   // Handle tapping on the "Listed" item in the drawer
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MySetting()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFFFFC201),
//         selectedItemColor: Colors.black, // Color of the active item
//         unselectedItemColor: Colors.grey, // Color of inactive items
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           // Handle tapping on navigation items
//           setState(() {
//             _currentIndex = index;
//           });
//           if (index == 0) {
//             // Navigate to the home page
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyHome()),
//             );
//             // You can push the home page or use your navigation logic
//           } else if (index == 1) {
//             // Handle other navigation items
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OrderScreen()),
//             );
//           } else if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MyEarnings()),
//             );
//
//           } else if (index == 3) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MySetting()),
//             );
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt_outlined), // Use outlined version
//             label: 'Orders',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.currency_rupee_rounded), // Use outlined version
//             label: 'My Earnings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined), // Use outlined version
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

//
//
// import 'package:flutter/material.dart';
// import 'package:fruitbox_delivery/screens/settings.dart';
// import 'create_profile.dart';
// import 'package:fruitbox_delivery/screens/user_details.dart';
//
// import 'home_screen.dart';
// import 'order_history.dart';
// import 'order_screen.dart';
//
// class MyEarnings extends StatefulWidget {
//   const MyEarnings({super.key});
//
//   @override
//   State<MyEarnings> createState() => _MyEarningsState();
// }
//
// class _MyEarningsState extends State<MyEarnings> {
//   int _currentIndex = 2; // Current index for the bottom navigation bar
//
//   // Global key for the scaffold state to open the drawer
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine screen width for responsive design
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: const Text(
//           'My Earnings',
//           style: TextStyle(
//             fontWeight: FontWeight.w100,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: const Color(0xFFFFC201),
//         leading: GestureDetector(
//           onTap: () {
//             scaffoldKey.currentState?.openDrawer(); // Open the drawer
//           },
//           child: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             Center(
//               child: Image.asset(
//                 'assets/images/earningsimg.png',
//                 width: screenWidth * 0.4,
//                 height: screenWidth * 0.4,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Center(
//               child: Text(
//                 'Your Earnings!',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // You can add more UI components here for earnings details
//           ],
//         ),
//
//       ),
//       drawer: buildDrawer(context),
//       bottomNavigationBar: buildBottomNavigationBar(context),
//     );
//   }
//
//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: const Text(
//               "John Maxwell",
//               style: TextStyle(color: Colors.black),
//             ),
//             accountEmail: const Text(
//               "johnmaxwell1234@email.com",
//               style: TextStyle(color: Colors.black),
//             ),
//             currentAccountPicture: const CircleAvatar(
//               backgroundImage: AssetImage("assets/images/deliveryimg.png"),
//             ),
//             decoration: const BoxDecoration(
//               color: Color(0xFFFFC201),
//             ),
//           ),
//           // Add list tiles for navigation options
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text("Home"),
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MyHome()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.person_outlined),
//             title: const Text("My Profile"),
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserDetailsScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.list_alt_outlined),
//             title: const Text("Orders"),
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const OrderScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings_outlined),
//             title: const Text("Settings"),
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => MySetting()),
//               );
//             },
//           ),
//           // Add more options if needed
//         ],
//       ),
//     );
//   }
//
//   BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: const Color(0xFFFFC201),
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.grey,
//       currentIndex: _currentIndex,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//         });
//         handleBottomNavigationTap(context, index);
//       },
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.list_alt_outlined),
//           label: 'Orders',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.currency_rupee_rounded),
//           label: 'My Earnings',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_outlined),
//           label: 'Settings',
//         ),
//       ],
//     );
//   }
//
//   void handleBottomNavigationTap(BuildContext context, int index) {
//     // Handle tapping on bottom navigation items
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyHome()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const OrderScreen()),
//         );
//         break;
//       case 2:
//       // Refresh the current screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyEarnings()),
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MySetting()),
//         );
//         break;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruitbox_delivery/screens/user_details.dart';
import 'package:fruitbox_delivery/screens/SideDrawer.dart';
import 'package:fruitbox_delivery/screens/BottomNavBar.dart';

import 'BottomNavBar.dart';
import 'SideDrawer.dart';

class MyEarnings extends StatefulWidget {
  const MyEarnings({Key? key}) : super(key: key);

  @override
  State<MyEarnings> createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
 // int _currentIndex = 2; // Current index for the bottom navigation bar
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  // Fetch earnings data from Firebase or any other source
  // You can modify this method to suit your data structure
  List<Map<String, dynamic>> getEarningsData() {
    // Mock data for demonstration
    return [


    ];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Earnings',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFFC201),
        leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Image.asset(
                'assets/images/earningsimg.png',
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Your Earnings!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Display earnings data
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: getEarningsData().length,
                itemBuilder: (context, index) {
                  final earnings = getEarningsData()[index];
                  return ListTile(
                    title: Text(earnings['title']),
                    subtitle: Text('Amount: \$${earnings['amount']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer:  SideDrawer(), // Use the SideDrawer widget
      bottomNavigationBar: const AppBottomNavigationBar(initialIndex: 2),
    );
  }
}
