// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitbox/features/home/screens/search_box.dart';
import '../../../common/widget/category_widget.dart';
import '../../../common/widget/card.dart';
import '../../../constants/global_variables.dart';
import '../../user/models/category_model.dart';
import '../../user/models/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? _lastBackPressTime;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ScrollController _homeScrollController;
  final TextEditingController _locationController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _homeScrollController = ScrollController();
  }

  @override
  void dispose() {
    _homeScrollController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          controller: _homeScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBox(
                onSearch: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
              if (_searchQuery.isEmpty) ...[
                _buildCategoriesSection(),
              ],
              _buildStreamBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: fetchUserFirstName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                final firstName = snapshot.data ?? '';
                return Text(
                  'Hi, $firstName',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                );
              }
            },
          ),
          const SizedBox(width: 8), // Space between the text and the address widget
          Expanded(
            child: FutureBuilder<String>(
              future: fetchUserAddress(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading address');
                } else {
                  String displayText;
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    displayText = snapshot.data!;
                  } else {
                    displayText = 'Add Address';
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "addressPage");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.black),
                              const SizedBox(width: 4), // Space between icon and text
                              Expanded(
                                child: Text(
                                  displayText,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        buildProfileButton(),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'bottomNav');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.black),
            title: const Text(
              'App Info',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _showComingSoonSnackbar(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.black),
            title: const Text(
              'Invite Friends',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _showComingSoonSnackbar(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy, color: Colors.black),
            title: const Text(
              'Policies',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _showComingSoonSnackbar(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.black),
            title: const Text(
              'Help and Support',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _showComingSoonSnackbar(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              _logout(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
        ),
      );
      return false;
    }
    return true;
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: appPading,
            left: appPading,
            bottom: appPading,
          ),
          child: Text(
            "Categories",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        CategoryWidget(scrollController: _homeScrollController),
      ],
    );
  }

  Widget _buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _searchQuery.isEmpty
          ? FirebaseFirestore.instance.collection('categories').snapshots()
          : FirebaseFirestore.instance
          .collection('products')
          .orderBy('name')
          .startAt([_searchQuery]).endAt(
          ['$_searchQuery\uf8ff']).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No matching results found.'));
        }

        final dataList = snapshot.data!.docs.map((doc) {
          if (_searchQuery.isEmpty) {
            return Category.fromSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>);
          } else {
            return Product(
              productId: doc.id,
              categoryName: doc['category_name'],
              description: doc['description'],
              imageUrl: doc['imageUrl'],
              name: doc['name'],
              price: doc['price'],
            );
          }
        }).toList();

        return Column(
          children: dataList.map((data) {
            if (data is Category) {
              return FutureBuilder<bool>(
                future: hasProductsForCategory(data.name),
                builder: (context, productSnapshot) {
                  if (productSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return productSnapshot.data == true
                      ? _buildCategoryProducts(data)
                      : const SizedBox.shrink();
                },
              );
            } else if (data is Product) {
              return ProductCard(product: data);
            } else {
              return const SizedBox.shrink();
            }
          }).toList(),
        );
      },
    );
  }

  void _showComingSoonSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature is coming soon!'),
      ),
    );
  }

  Widget _buildCategoryProducts(Category category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: appPading, left: appPading),
          child: Text(
            category.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        PopularItemsWidget(category: category),
      ],
    );
  }

  Widget buildProfileButton() {
    return _auth.currentUser == null
        ? TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, 'register');
            },
            icon: const Icon(Icons.login, color: Colors.black),
            label: const Text('Login', style: TextStyle(color: Colors.black)),
          )
        : IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
            padding: const EdgeInsets.only(right: appPading),
            icon: const Icon(CupertinoIcons.person_alt_circle_fill,
                color: Colors.black, size: 35),
          );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, 'register');
    } catch (error) {
      print('Error signing out');
    }
  }

  Future<bool> hasProductsForCategory(String categoryName) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category_name', isEqualTo: categoryName)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error checking products');
      return false;
    }
  }

  Future<String> fetchUserAddress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        String userAddress = userDoc['address'] ?? '';
        return userAddress;
      } else {
        return '';
      }
    } catch (e) {
      print('Error fetching user address');
      return '';
    }
  }

  Future<String> fetchUserFirstName() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return '';
    }
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      final fullName = userDoc.data()?['name'];
      if (fullName != null && fullName.isNotEmpty) {
        final firstName = fullName.split(' ').first;
        return firstName;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }}
