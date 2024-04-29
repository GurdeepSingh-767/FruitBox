// import 'package:flutter/material.dart';
// import 'package:fruitbox_delivery/screens/earningsScreen.dart';
// import 'package:fruitbox_delivery/screens/settings.dart';
// import 'create_profile.dart';
// import 'order_history.dart';
// import 'order_screen.dart';
//
// class MyHome extends StatefulWidget {
//   const MyHome({super.key});
//
//   @override
//   State<MyHome> createState() => _MyHomeState();
// }
//
// class _MyHomeState extends State<MyHome> {
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: const Text(
//           'Home',
//           style: TextStyle(
//             fontWeight: FontWeight.w100,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: const Color(0xFFFFC201),
//         leading: GestureDetector(
//           onTap: () {
//             scaffoldKey.currentState?.openDrawer();
//           },
//           child: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           double screenWidth = constraints.maxWidth;
//           double buttonWidth = screenWidth * 0.4;
//           double buttonHeight = 150.0;
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Center(
//                   child: Image.asset(
//                     'assets/images/deliveryimg.png',
//                     width: screenWidth * 0.4,
//                     height: screenWidth * 0.4,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Center(
//                   child: Text(
//                     'Start Your Journey Now!!',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSquareButton(
//                       label: 'New Orders',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const OrderScreen()),
//                         );
//                       },
//                       width: buttonWidth,
//                       height: buttonHeight,
//                     ),
//                     _buildSquareButton(
//                       label: 'My Earnings',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MyEarnings()),
//                         );
//                       },
//                       width: buttonWidth,
//                       height: buttonHeight,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSquareButton(
//                       label: 'Order In Progress',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MyEarnings()),
//                         );
//                       },
//                       width: buttonWidth,
//                       height: buttonHeight,
//                     ),
//                     _buildSquareButton(
//                       label: 'Not Yet Delivered',
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const MyEarnings()),
//                         );
//                       },
//                       width: buttonWidth,
//                       height: buttonHeight,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       drawer: Drawer(
//         child: Container(
//           decoration: const BoxDecoration(),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: const BoxDecoration(
//                   color: Colors.white70,
//                 ),
//                 child: Image.asset(
//                  "assets/images/fruitbox_logo.png",
//                   //"assets/images/deliveryimg.png",
//                   width: 200, // Adjust the width as needed
//                   height: 200, // Adjust the height as needed
//                   fit: BoxFit.contain, // Adjust the fit as needed
//                 ),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.home),
//                 title: const Text("Home"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyHome()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.person_outlined),
//                 title: const Text("My Profile"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Profile()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.list_alt_outlined),
//                 title: const Text("Orders"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const OrderScreen()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history_outlined),
//                 title: const Text("History"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const OrderHistory()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.currency_rupee_rounded),
//                 title: const Text("Your Earnings"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyEarnings()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.local_shipping_outlined),
//                 title: const Text("Orders in progress"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const OrderScreen()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.directions_bike),
//                 title: const Text("Not yet delivered"),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const OrderScreen()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.settings_outlined),
//                 title: const Text("Settings"),
//                 onTap: () {
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
//         backgroundColor: const Color(0xFFFFC201),
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MyHome()),
//               );
//               break;
//             case 1:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const OrderScreen()),
//               );
//               break;
//             case 2:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MyEarnings()),
//               );
//               break;
//             case 3:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => MySetting()),
//               );
//               break;
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt_outlined),
//             label: 'Orders',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.currency_rupee_rounded),
//             label: 'My Earnings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSquareButton({
//     required String label,
//     required VoidCallback onPressed,
//     required double width,
//     required double height,
//   }) {
//     return Container(
//       height: height,
//       width: width,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 10.0,
//           backgroundColor: const Color(0xFFFFC201),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18.0,
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.center, // Center the text
//           overflow: TextOverflow.ellipsis, // Handle overflow
//         ),
//       ),
//     );
//   }
//
//   }
//

//
// import 'package:flutter/material.dart';
// import 'package:fruitbox_delivery/screens/earningsScreen.dart';
// import 'package:fruitbox_delivery/screens/user_details.dart';
// import 'package:fruitbox_delivery/screens/SideDrawer.dart';
// import 'package:fruitbox_delivery/screens/BottomNavBar.dart';
//
// import 'BottomNavBar.dart';
// import 'SideDrawer.dart';
// import 'package:fruitbox_delivery/screens/settings.dart';
// import 'create_profile.dart';
// import 'order_history.dart';
// import 'order_screen.dart';
//
// class MyHome extends StatefulWidget {
//   const MyHome({super.key});
//
//   @override
//   State<MyHome> createState() => _MyHomeState();
// }
//
// class _MyHomeState extends State<MyHome> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//
//         title: const Text(
//           'Home',
//
//           style: TextStyle(
//             fontWeight: FontWeight.w100,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: const Color(0xFFFFC201),
//         leading: GestureDetector(
//           onTap: () {
//             scaffoldKey.currentState?.openDrawer();
//           },
//           child: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 15),
//             Center(
//               child: Image.asset(
//                 'assets/images/deliveryimg.png',
//                 width: screenWidth * 0.4,
//                 height: screenWidth * 0.4,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Center(
//               child: Text(
//                 'Start Your Journey Now!!',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                   label: 'New Orders',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const OrderScreen()),
//                     );
//                   },
//                   width: screenWidth * 0.4,
//                   height: 150,
//                 ),
//                 _buildSquareButton(
//                   label: 'My Earnings',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const MyEarnings()),
//                     );
//                   },
//                   width: screenWidth * 0.4,
//                   height: 150,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                   label: 'Order In Progress',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const OrderScreen()),
//                     );
//                   },
//                   width: screenWidth * 0.4,
//                   height: 150,
//                 ),
//                 _buildSquareButton(
//                   label: 'Not Yet Delivered',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const OrderScreen()),
//                     );
//                   },
//                   width: screenWidth * 0.4,
//                   height: 150,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//       drawer: buildDrawer(context),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFFFFC201),
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MyHome()),
//               );
//               break;
//             case 1:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const OrderScreen()),
//               );
//               break;
//             case 2:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MyEarnings()),
//               );
//               break;
//             case 3:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => MySetting()),
//               );
//               break;
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt_outlined),
//             label: 'Orders',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.currency_rupee_rounded),
//             label: 'My Earnings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
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
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSquareButton({
//     required String label,
//     required VoidCallback onPressed,
//     required double width,
//     required double height,
//   }) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 10.0,
//           backgroundColor: const Color(0xFFFFC201),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 18.0,
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fruitbox_delivery/screens/SideDrawer.dart';
import 'package:fruitbox_delivery/screens/BottomNavBar.dart'; // Importing the BottomNavBar

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Home',
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
                scaffoldKey.currentState?.openDrawer();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Placeholder for your user details UI
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/deliveryimg.png',
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Start Your Journey Now!!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquareButton(
                  label: 'Orders',
                  onPressed: () {
                    Navigator.pushNamed(context, 'order_screen'); // Handle New Orders button press
                  },
                  width: screenWidth * 0.4,
                  height: 150,
                ),
                _buildSquareButton(
                  label: 'My Earnings',
                  onPressed: () {
                    Navigator.pushNamed(context, 'earningsScreen'); // Handle My Earnings button press
                  },
                  width: screenWidth * 0.4,
                  height: 150,
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: const AppBottomNavigationBar(

          initialIndex: 0 // Handle bottom navigation item taps

      ),
    );
  }

  Widget _buildSquareButton({
    required String label,
    required VoidCallback onPressed,
    required double width,
    required double height,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          backgroundColor: const Color(0xFFFFC201),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
