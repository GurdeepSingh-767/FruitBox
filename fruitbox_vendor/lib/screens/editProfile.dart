import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC201),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Update Your Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              //onChanged: (){},
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              //onChanged: (value) => setState(() => email = value),
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              //onChanged: (value) => setState(() => address = value),
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                 // Save the data to Firestore
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC201),
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
