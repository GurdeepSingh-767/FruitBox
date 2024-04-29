import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'BottomNavBar.dart';
import 'SideDrawer.dart';
import 'auth_register.dart';
class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  int _currentIndex = 0;
  String name = '';
  String phoneNo = '';
  String email = '';
  String workLocation = '';
  String selectedVehicle = 'Bike';
  String selectedWorkTiming = 'Full Time';
  String profilePhotoUrl = '';

  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  List<String> vehicleOptions = ['Bike', 'EV', 'Cycle', 'Other'];
  List<String> workTimingOptions = ['Full Time', 'Part Time', 'Weekends Only'];

  Future<void> fetchUserDetails() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        return;
      }

      final userDocument = await FirebaseFirestore.instance.collection('drivers').doc(userId).get();

      if (userDocument.exists) {
        final userData = userDocument.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            name = userData['name'] ?? '';
            phoneNo = userData['contactNo'] ?? '';
            email = userData['email'] ?? '';
            workLocation = userData['workLocation'] ?? '';
            selectedVehicle = userData['selectedVehicle'] ?? 'Bike';
            selectedWorkTiming = userData['selectedWorkTiming'] ?? 'Full Time';
            profilePhotoUrl = userData['profilePhotoUrl'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> saveUserDetails(String fieldName, dynamic value) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        return;
      }

      final drivers = FirebaseFirestore.instance.collection('drivers');

      await drivers.doc(userId).update({
        fieldName: value,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error saving user details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving changes. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        return;
      }

      try {
        final storageRef = FirebaseStorage.instance.ref().child('drivers_profile_image/$userId.jpg');
        final uploadTask = storageRef.putFile(file);
        final taskSnapshot = await uploadTask.whenComplete(() => {});
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await saveUserDetails('profilePhotoUrl', downloadUrl);

        setState(() {
          profilePhotoUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile photo updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Error uploading profile photo: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading profile photo. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
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
        child: Column(
          children: [
            Card(
              elevation: 2,
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: pickAndUploadImage,

                   child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: profilePhotoUrl.isNotEmpty
                              ? Image.network(
                            profilePhotoUrl,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            "assets/images/deliveryimg.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text('Phone Number: $phoneNo'),
                  ),
                  ListTile(
                    title: Text('Name: $name'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newName = name; // Initialize a new variable to hold the edited name
                            return AlertDialog(
                              title: const Text('Edit Name'),
                              content: TextFormField(
                                initialValue: name,
                                decoration: const InputDecoration(labelText: 'Name'),
                                onChanged: (value) {
                                  newName = value; // Update the new name as it's being edited
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    saveUserDetails('name', newName); // Save the edited name
                                    setState(() {
                                      name = newName; // Update the state with the edited name
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

                  ListTile(
                    title: Text('Email: $email'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newEmail = email;
                            return AlertDialog(
                              title: const Text('Edit Email'),
                              content: TextFormField(
                                initialValue: email,
                                decoration: const InputDecoration(labelText: 'Email'),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  newEmail = value;
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    saveUserDetails('email', newEmail);
                                    setState(() {
                                      email = newEmail;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Work Location: $workLocation'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newWorkLocation = workLocation;
                            return AlertDialog(
                              title: const Text('Edit Work Location'),
                              content: TextFormField(
                                initialValue: workLocation,
                                decoration: const InputDecoration(labelText: 'Work Location'),
                                onChanged: (value) {
                                  newWorkLocation = value;
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    saveUserDetails('workLocation', newWorkLocation);
                                    setState(() {
                                      workLocation = newWorkLocation;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Vehicle: $selectedVehicle'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newSelectedVehicle = selectedVehicle;
                            return AlertDialog(
                              title: const Text('Edit Vehicle'),
                              content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return DropdownButtonFormField<String>(
                                    value: selectedVehicle,
                                    items: vehicleOptions
                                        .map((vehicle) => DropdownMenuItem(
                                      value: vehicle,
                                      child: Text(vehicle),
                                    ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        newSelectedVehicle = value!;
                                      });
                                    },
                                  );
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    saveUserDetails('selectedVehicle', newSelectedVehicle);
                                    setState(() {
                                      selectedVehicle = newSelectedVehicle;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Work Timing: $selectedWorkTiming'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newSelectedWorkTiming = selectedWorkTiming;
                            return AlertDialog(
                              title: const Text('Edit Work Timing'),
                              content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return DropdownButtonFormField<String>(
                                    value: selectedWorkTiming,
                                    items: workTimingOptions
                                        .map((timing) => DropdownMenuItem(
                                      value: timing,
                                      child: Text(timing),
                                    ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        newSelectedWorkTiming = value!;
                                      });
                                    },
                                  );
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    saveUserDetails('selectedWorkTiming', newSelectedWorkTiming);
                                    setState(() {
                                      selectedWorkTiming = newSelectedWorkTiming;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      logout(context); // Pass the context to the logout function
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(initialIndex: 3),
      drawer: SideDrawer(),
    );
  }


  void logout(BuildContext context) async { // Accept the context parameter
    await _auth.signOut();
    print('User signed out');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Register())); // Use Navigator.pushReplacement with a MaterialPageRoute
  }
}
