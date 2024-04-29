// import 'package:flutter/material.dart';
// import 'BottomNavBar.dart';
// import 'SideDrawer.dart';
// import 'auth_register.dart';
// class MySetting extends StatefulWidget {
//   @override
//   _MySettingState createState() => _MySettingState();
// }
//
// class _MySettingState extends State<MySetting> {
//   TextEditingController _phoneController = TextEditingController();
//
//   int _currentIndex = 3;
//
//   _showSignOutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Center(
//             child: Text(
//               "Sign Out",
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           content: const Text(
//             "Are you sure you want to sign out?",
//             style: TextStyle(color: Colors.black),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(
//                   color: Colors.blue,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text(
//                 "Sign Out",
//                 style: TextStyle(
//                   color: Colors.blue,
//                 ),
//               ),
//               onPressed: () {
//                 // Perform sign-out logic here
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => const Register(),
//                 ));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   _showChangePhoneNumberDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Change Phone Number"),
//           content: TextFormField(
//             controller: _phoneController,
//             decoration: const InputDecoration(labelText: "New Phone Number"),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(
//                   color: Colors.blue,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text(
//                 "Save",
//                 style: TextStyle(
//                   color: Colors.blue,
//                 ),
//               ),
//               onPressed: () {
//                 // Implement logic to update the phone number in your data store.
//                 // You can use _phoneController.text to get the new phone number.
//                 // After updating the phone number, you can return to the previous screen.
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Settings',
//             style: TextStyle(
//               fontWeight: FontWeight.w100,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         backgroundColor: const Color(0xFFFFC201),
//       ),
//       body: ListView(
//         children: <Widget>[
//           const SizedBox(height: 20),
//           ListTile(
//             leading: const Icon(Icons.phone),
//             title: const Text('Change Phone Number'),
//             onTap: () {
//               _showChangePhoneNumberDialog(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Sign Out'),
//             onTap: () {
//               _showSignOutDialog(context);
//             },
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//       drawer:  SideDrawer(),
//       bottomNavigationBar: const AppBottomNavigationBar(initialIndex: 3),
//     );
//   }
// }
