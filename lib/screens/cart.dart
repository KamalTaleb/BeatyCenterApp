import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/screens/checkout.dart';
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/screens/staff_check.dart';
import 'package:beauty_center/services_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SCartScreen extends StatefulWidget {
  const SCartScreen({super.key});

  @override
  _SCartScreenState createState() => _SCartScreenState();
}

class _SCartScreenState extends State<SCartScreen> {
  Map<String, List<Map<String, dynamic>>> _servicesByCategory = {};

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.1.9/senior/get_services.php'));
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
            'duration': service['duration'],
            'price': service['price'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppbar(
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const homePage()),
        );},
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
                  // Space between category and services
                  ...services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      // Space between services
                      child: SServicesCardHorizontal(
                        id: service['id'],
                        name: service['name'],
                        description: service['description'],
                        duration: service['duration'],
                        price: service['price'],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  // Space between different categories
                ],
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SCheckStaff(),
                ),
              );
            },
            child: const Text('Checkout \$213.0'),
          ),
        ),
      ),
    );
  }
}
