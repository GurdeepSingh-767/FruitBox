import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  AddressPageState createState() => AddressPageState();
}

class AddressPageState extends State<AddressPage> {
  LatLng? _currentLocation;
  String? _currentAddress;
  Timer? _debounceTimer;
  Duration debounceDuration = const Duration(milliseconds: 500);
  late Future<void> _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        LatLng currentLocation = LatLng(position.latitude, position.longitude);
        setState(() {
          _currentLocation = currentLocation;
        });
        await _fetchCurrentAddress(currentLocation);
      }else {
        print('Location permission denied');
      }
    } catch (e) {
      print('Error fetching current location: $e');
    }
  }

  Future<void> _fetchCurrentAddress(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        final address = placemarks.first;
        setState(() {
          _currentAddress =
              '${address.street}, ${address.locality}, ${address.country}';
        });
      } else {
        print('No address found for the given coordinates.');
      }
    } catch (e) {
      print('Error fetching current address: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {}

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentLocation = position.target;
    });

    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(debounceDuration, () {
      _fetchCurrentAddress(position.target);
    });
  }

  Future<void> _saveAddress() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (_currentAddress != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'address': _currentAddress});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address saved successfully')),
        );
        Navigator.pushReplacementNamed(context, 'bottomNav');
      }
    } catch (e) {
      print('Error saving address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Page'),
      ),
      body: FutureBuilder<void>(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Select from the map',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_currentLocation != null)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation!,
                        zoom: 14.0,
                      ),
                      onMapCreated: _onMapCreated,
                      markers: {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: _currentLocation!,
                          infoWindow: const InfoWindow(title: 'Your Location'),
                          draggable: true,
                          onDragEnd: (newPosition) {
                            setState(() {
                              _currentLocation = newPosition;
                            });
                            if (_debounceTimer != null) {
                              _debounceTimer!.cancel();
                            }
                            _debounceTimer = Timer(debounceDuration, () {
                              _fetchCurrentAddress(newPosition);
                            });
                          },
                        ),
                      },
                      onCameraMove: _onCameraMove,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Current Address: $_currentAddress',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _saveAddress,
                    child: const Text('Save Address'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
