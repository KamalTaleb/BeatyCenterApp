import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSelectionScreen extends StatefulWidget {
  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  late GoogleMapController mapController;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Initial map center
                    zoom: 15, // Initial zoom level
                  ),
                  onTap: (LatLng location) {
                    setState(() {
                      _selectedLocation = location;
                      _markers.clear(); // Clear previous markers
                      _markers.add(
                        Marker(
                          markerId: const MarkerId('selectedLocation'),
                          position: location,
                        ),
                      );
                    });
                  },
                  markers: _markers,
                ),
              ],
            ),
          ),
          if (_selectedLocation != null)
            Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Selected Location:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Latitude: ${_selectedLocation!.latitude}, Longitude: ${_selectedLocation!.longitude}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle the selected location
                if (kDebugMode) {
                  print('Selected location: $_selectedLocation');
                }
                Navigator.pop(context, _selectedLocation);
              },
              child: const Text('Insert Location'),
            ),
          ),
        ],
      ),
    );
  }
}
