import 'package:beauty_center/screens/staff_view_as_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SCartScreen extends StatefulWidget {
  const SCartScreen({super.key});

  @override
  _SCartScreenState createState() => _SCartScreenState();
}

class _SCartScreenState extends State<SCartScreen> {
  Map<String, List<Map<String, dynamic>>> _servicesByCategory = {};
  List<Map<String, dynamic>> _selectedServices = [];
  int? _userId;

  @override
  void initState() {
    super.initState();
    _fetchServices();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('user_id');
    });
    print('User ID: $_userId'); // Print the user ID for debugging
  }

  Future<void> _fetchServices() async {
    try {
      var response = await http.get(Uri.parse('http://172.20.10.5/senior/get_services.php'));
      if (response.statusCode == 200) {
        List<dynamic> servicesList = json.decode(response.body);
        Map<String, List<Map<String, dynamic>>> servicesByCategory = {};
        for (var service in servicesList) {
          String category = service['category'] ?? 'Uncategorized';
          if (!servicesByCategory.containsKey(category)) {
            servicesByCategory[category] = [];
          }
          servicesByCategory[category]?.add({
            'id': int.parse(service['id']),
            'name': service['name'],
            'description': service['description'],
            'price': service['price'],
            'category': service['category'],
          });
        }
        setState(() {
          _servicesByCategory = servicesByCategory;
        });
      } else {
        print('Failed to load services');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _updateSelectedServices(Map<String, dynamic> service, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedServices.add(service);
      } else {
        _selectedServices.removeWhere((s) => s['id'] == service['id']);
      }
    });
  }

  double get _totalPrice {
    return _selectedServices.fold(0, (sum, service) => sum + double.parse(service['price']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: _servicesByCategory.entries.map((entry) {
              String category = entry.key;
              List<Map<String, dynamic>> services = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ServiceCardHorizontal(
                        id: service['id'],
                        name: service['name'],
                        description: service['description'],
                        price: service['price'],
                        onSelectionChanged: (isSelected) {
                          _updateSelectedServices(service, isSelected);
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _selectedServices.isEmpty
              ? null
              : () {
            Get.to(() => StaffViewAsGrid(
              selectedServices: _selectedServices,
              userId: _userId,
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_totalPrice.toStringAsFixed(2)}'),
              Text('${_selectedServices.length} services'),
              Text('Continue'),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCardHorizontal extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final String price;
  final ValueChanged<bool> onSelectionChanged;

  const ServiceCardHorizontal({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.onSelectionChanged,
  });

  @override
  _ServiceCardHorizontalState createState() => _ServiceCardHorizontalState();
}

class _ServiceCardHorizontalState extends State<ServiceCardHorizontal> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
      widget.onSelectionChanged(_isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: dark ? const Color(0xFF939393) : const Color(0xFFF4F4F4),
        ),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: dark ? const Color(0xFF272727) : const Color(0xFFF6F6F6),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: _isSelected ? Colors.teal : Colors.black54,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: SizedBox(
                            width: 32.0 * 1.2,
                            height: 32.0 * 1.2,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: _toggleSelection,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
