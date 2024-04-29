import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox_vendor/screens/home.dart';
import 'package:fruitbox_vendor/screens/orders.dart';
import 'package:fruitbox_vendor/screens/settings.dart';

class MyItem extends StatefulWidget {
  @override
  _MyItemState createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Listed Fruits',
          style: TextStyle(
            fontWeight: FontWeight.w100,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFFC201),
      ),
      body: FutureBuilder<List<Fruit>>(
        future: fetchFruitsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Fruit> fruits = snapshot.data!;
            return ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                Fruit fruit = fruits[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Image.network(
                        fruit.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible( // Wrap the text widget with Flexible
                          child: Text(
                            fruit.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                            maxLines: 1, // Limit to 1 line
                          ),
                        ),
                        Switch(
                          value: fruit.isAvailable,
                          onChanged: (value) async {
                            setState(() {
                              fruit.isAvailable = value;
                            });
                            await updateFruitAvailability(fruit); // Update availability in Firestore
                          },
                          activeColor: Colors.black,
                          inactiveThumbColor: Colors.grey,
                        ),
                      ],
                    ),
                    subtitle: Text('\₹${fruit.price}/kg'),
                    tileColor: Color(0xFFFFC201),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No fruits found.'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFC201),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHome()),
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

  Future<List<Fruit>> fetchFruitsFromDatabase() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();

    List<Fruit> fruits = [];
    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;
      fruits.add(Fruit(
        name: data['name'] ?? '',
        price: (data['price'] ?? ''),
        imageUrl: data['imageUrl'] ?? '',
        isAvailable: data['isAvailable'] ?? true,
        docId: doc.id, // Add document ID to update Firestore document
      ));
    });
    return fruits;
  }

  Future<void> updateFruitAvailability(Fruit fruit) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(fruit.docId).update({
        'isAvailable': fruit.isAvailable,
      });
    } catch (e) {
      print('Error updating availability: $e');
    }
  }
}

class Fruit {
  final String name;
  final String price;
  final String imageUrl;
  bool isAvailable;
  String docId; // Document ID in Firestore

  Fruit({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isAvailable = true,
    required this.docId,
  });
}
