import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/home.dart';
import 'package:fruitbox_vendor/screens/items.dart';
import 'package:fruitbox_vendor/screens/login.dart';
import 'package:fruitbox_vendor/screens/orders.dart';



class MySetting extends StatefulWidget {
  @override
  _MySettingState createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  int _currentIndex = 3;
  TextEditingController _phoneController = TextEditingController();

  _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          content: Text(
            "Are you sure you want to sign out?",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                // Perform sign-out logic here
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyLogin(),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  _showChangePhoneNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Phone Number"),
          content: TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: "New Phone Number"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                // Implement logic to update the phone number in your data store.
                // You can use _phoneController.text to get the new phone number.
                // After updating the phone number, you can return to the previous screen.
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.w100,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFC201),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Change Phone Number'),
            onTap: () {
              _showChangePhoneNumberDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFC201),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle tapping on navigation items
          if (index == 0) {
            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
            );
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
            // Handle the Settings tab
          }
          setState(() {
            
            
            

            _currentIndex = index;
                
                
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart_outlined),
            label: 'Listed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
