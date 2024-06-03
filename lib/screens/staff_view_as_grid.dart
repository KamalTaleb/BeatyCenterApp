import 'package:beauty_center/screens/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StaffViewAsGrid extends StatefulWidget {
  final List<Map<String, dynamic>> selectedServices;
  final int? userId;

  const StaffViewAsGrid({super.key, required this.selectedServices, required this.userId});

  @override
  _StaffViewAsGridState createState() => _StaffViewAsGridState();
}

class _StaffViewAsGridState extends State<StaffViewAsGrid> {
  Map<int, Map<String, String>> _selectedStaffForServices = {}; // Service ID to Staff Info mapping
  Map<int, List<Map<String, dynamic>>> serviceStaffMap = {}; // Service ID to Staff List mapping

  @override
  void initState() {
    super.initState();
    _fetchStaff();
  }

  Future<void> _fetchStaff() async {
    for (var service in widget.selectedServices) {
      String category = service['category'];
      int serviceId = service['id'];

      try {
        var response = await http.post(
          Uri.parse('http://172.20.10.5/senior/get_staff_by_specialty.php'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'specialty': category}),
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          List<dynamic> staffList = json.decode(response.body);
          setState(() {
            serviceStaffMap[serviceId] = staffList.map<Map<String, dynamic>>((staff) => {
              'id': staff['id'].toString(),
              'path': staff['image'],
              'title': staff['name'],
            }).toList();
          });
        } else {
          print('Failed to load staff for category: $category. Response code: ${response.statusCode}. Response body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching staff for category $category: $e');
        print('Exception details: ${e.toString()}');
      }
    }
  }

  void _onStaffSelected(int serviceId, String staffId, String staffName, String staffImage) {
    setState(() {
      _selectedStaffForServices[serviceId] = {
        'id': staffId,
        'name': staffName,
        'image': staffImage,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Staff for Each Service'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.selectedServices.length,
        itemBuilder: (context, index) {
          final service = widget.selectedServices[index];
          final serviceId = service['id'];
          final staffList = serviceStaffMap[serviceId] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Staff for ${service['name']}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1, // 1:1 aspect ratio for square images
                ),
                itemCount: staffList.length,
                itemBuilder: (context, index) {
                  final staff = staffList[index];
                  return SelectableImageWithTitle(
                    imagePath: staff['path']!,
                    title: staff['title']!,
                    isSelected: _selectedStaffForServices[serviceId]?['id'] == staff['id'],
                    onTap: () => _onStaffSelected(serviceId, staff['id']!, staff['title']!, staff['path']!),
                  );
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[700],
            foregroundColor: Colors.white,
          ),
          onPressed: _selectedStaffForServices.length == widget.selectedServices.length
              ? () {
            Get.to(() => SBookingCalendarPage(
              selectedServices: widget.selectedServices,
              selectedStaffForServices: _selectedStaffForServices,
              userId: widget.userId,
            ));
          }
              : null,
          child: const Text('Continue'),
        ),
      ),
    );
  }
}

class SelectableImageWithTitle extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableImageWithTitle({
    required this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.transparent,
            width: 3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
