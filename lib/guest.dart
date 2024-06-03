import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/screens/checkout.dart';
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/staff_view_as_grid.dart';
import 'package:beauty_center/services_card_horizontal.dart';
import 'package:beauty_center/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class guest extends StatefulWidget {
  const guest({super.key});

  @override
  _guestState createState() => _guestState();
}

class _guestState extends State<guest> {
  Map<String, List<Map<String, dynamic>>> _servicesByCategory = {};
  List<Map<String, dynamic>> _selectedServices = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchServices();
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
          if (_servicesByCategory.isNotEmpty) {
            _selectedCategory = _servicesByCategory.keys.first;
          }
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
      appBar: SAppbar(
        onPressed: () {
        Get.back();
        },
        showBackArrow: true,
        title: Text(
          'Services',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              if (_servicesByCategory.isNotEmpty)
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _servicesByCategory.keys.map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16),
              if (_selectedCategory != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _servicesByCategory[_selectedCategory]!.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      // Space between services
                      child: SServicesCardHorizontal(
                        id: service['id'],
                        name: service['name'],
                        description: service['description'],
                        price: service['price'],
                        onSelectionChanged: (bool isSelected) {},
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {}, // Disable continue button by assigning an empty function
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
