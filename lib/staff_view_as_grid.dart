// import 'package:beauty_center/screens/booking_calendar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class StaffViewAsGrid extends StatefulWidget {
//   final List<Map<String, dynamic>> selectedServices;
//   final int? userId;
//
//   const StaffViewAsGrid({super.key, required this.selectedServices, required this.userId});
//
//   @override
//   _StaffViewAsGridState createState() => _StaffViewAsGridState();
// }
//
// class _StaffViewAsGridState extends State<StaffViewAsGrid> {
//   Set<String> selectedImagePaths = {};
//   Map<String, List<Map<String, dynamic>>> sections = {};
//   String? _selectedStaffName;
//   String? _selectedStaffImage;
//   String? _selectedStaffId;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStaff();
//   }
//
//   Future<void> _fetchStaff() async {
//     Set<String> selectedCategories = widget.selectedServices.map<String>((s) => s['category'] as String).toSet();
//     for (String category in selectedCategories) {
//       try {
//         var response = await http.post(
//           Uri.parse('http://192.168.1.12/senior/get_staff_by_specialty.php'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({'specialty': category}),
//         );
//         print('Response status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         if (response.statusCode == 200) {
//           List<dynamic> staffList = json.decode(response.body);
//           setState(() {
//             sections[category] = staffList.map<Map<String, dynamic>>((staff) => {
//               'id': staff['id'].toString(),
//               'path': staff['image'],
//               'title': staff['name'],
//             }).toList();
//           });
//         } else {
//           print('Failed to load staff for category: $category. Response code: ${response.statusCode}. Response body: ${response.body}');
//         }
//       } catch (e) {
//         print('Error fetching staff for category $category: $e');
//         print('Exception details: ${e.toString()}');
//       }
//     }
//   }
//
//   void _onImageTap(String imagePath, String staffId, String staffName) {
//     setState(() {
//       selectedImagePaths.clear();
//       selectedImagePaths.add(imagePath);
//       _selectedStaffId = staffId;
//       _selectedStaffName = staffName;
//       _selectedStaffImage = imagePath;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Staff'),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Get.back();
//             }),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: CustomScrollView(
//               slivers: sections.entries.expand((entry) {
//                 String category = entry.key;
//                 List<Map<String, dynamic>> images = entry.value;
//                 return [
//                   SliverList(
//                     delegate: SliverChildListDelegate([
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           category,
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   SliverPadding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     sliver: SliverGrid(
//                       gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, // Number of columns
//                         crossAxisSpacing: 8, // Space between columns
//                         mainAxisSpacing: 8, // Space between rows
//                         childAspectRatio: 3 / 2, // Aspect ratio for the items
//                       ),
//                       delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                           final image = images[index];
//                           return SelectableImageWithTitle(
//                             imagePath: image['path']!,
//                             title: image['title']!,
//                             isSelected: selectedImagePaths.contains(image['path']),
//                             onTap: () => _onImageTap(image['path']!, image['id']!, image['title']!),
//                           );
//                         },
//                         childCount: images.length,
//                       ),
//                     ),
//                   ),
//                 ];
//               }).toList(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: ElevatedButton(
//               onPressed: selectedImagePaths.isEmpty
//                   ? null
//                   : () {
//                 Get.to(() => SBookingCalendarPage(
//                   selectedServices: widget.selectedServices,
//                   selectedStaffId: _selectedStaffId,
//                   userId: widget.userId,
//                 ));
//               },
//               child: const Text('Continue'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SelectableImageWithTitle extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const SelectableImageWithTitle({
//     required this.imagePath,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: isSelected ? Colors.teal : Colors.transparent,
//                   width: 3,
//                 ),
//                 image: DecorationImage(
//                   image: NetworkImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
