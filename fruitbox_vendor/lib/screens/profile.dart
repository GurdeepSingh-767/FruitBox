import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/editProfile.dart';



class ProfilePage extends StatefulWidget {
  final String vendorName;
  //final String vendorId;
  final String email;

  const ProfilePage({
    Key? key,
    required this.vendorName,
    //required this.vendorId,
    required this.email,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String contact = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    fetchProfileInfo();
  }

  void fetchProfileInfo() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .where('email', isEqualTo: widget.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one vendor with the provided email
        var vendorData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          // Update the state with fetched data
          contact = vendorData['contact'] ?? '';
          address = vendorData['address'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching profile information: $e');
      // Handle errors, e.g., show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching profile information'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Vendor Profile'),
        backgroundColor: Color(0xFFFFC201),
        leading: GestureDetector(
          onTap: () {
            // Open the drawer on tap
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back, // Hamburger menu icon
            color: Colors.black, // Set the color of the icon
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/ashish.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Vendor Name: ${widget.vendorName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${widget.email}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: $contact',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Address: $address',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            // Handle logout button press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfile()),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFC201)),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
