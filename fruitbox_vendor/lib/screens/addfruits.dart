import 'package:flutter/material.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';


class ItemListingScreen extends StatefulWidget {
  @override
  _ItemListingScreenState createState() => _ItemListingScreenState();
}

class _ItemListingScreenState extends State<ItemListingScreen> {
  String name = '';
  double price = 0.0;
  String description = '';
  double weight = 0.0;
  File? _image;
  String? selectedCategory;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories when the screen initializes
  }

  Future<void> _fetchCategories() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    if (snapshot.docs.isNotEmpty) {
      List<String> _categories = [];
      snapshot.docs.forEach((doc) {
        _categories.add(
            doc['name']); // Change 'name' to the actual field in your document
      });

      setState(() {
        categories = _categories;
      });
    }
  }

  Future<void> _postFruitData() async {
    if (_image == null || name.isEmpty || selectedCategory == null) {
      print('Please fill all required fields');
      return;
    }

    // Upload the image to Firebase Storage
    final imageUrl = await _uploadImage(_image!);

    // Add the fruit data to Firestore with the image URL
    try {
      final fruitCollection = FirebaseFirestore.instance.collection('fruits');
      await fruitCollection.add({
        'name': name,
        'price': price,
        'description': description,
        'category': selectedCategory,
        'image_url': imageUrl,
        // Add other fields as needed
      });

      // Navigate back after successful upload
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      // Handle any potential errors here, e.g., show a snackbar
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('fruits')
          .child('image_${DateTime.now().millisecondsSinceEpoch}.png');

      // Uploading the file to Firebase Storage
      final uploadTask = ref.putFile(imageFile);

      // Awaiting the completion of the upload task
      await uploadTask;

      // Retrieving the download URL after the upload is complete
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  Future _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  InputDecoration dropdownDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC201),
        title: Text(
          'Add Fruits',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Fruit Details:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items:
                    categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                hint: Text('Select a category'),
                isExpanded: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Price (\₹)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            _image != null
                ? Image.network(
                    _image!.path,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : ElevatedButton(
                    onPressed: _getImage,
                    child: Text(
                      'Select Image',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC201),
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _postFruitData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC201),
              ),
              child: Text(
                'Add fruit',
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

void main() {
  runApp(MaterialApp(
    home: ItemListingScreen(),
  ));
}
