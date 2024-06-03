import 'package:beauty_center/screens/add_feedback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'appointment_page.dart';

class SCompletedPage extends StatefulWidget {
  const SCompletedPage({super.key});

  @override
  State<SCompletedPage> createState() => _SCompletedPageState();
}

class _SCompletedPageState extends State<SCompletedPage> {
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      try {
        var response = await http.get(Uri.parse('http://172.20.10.5/senior/get_user_schedule.php?user_id=$userId'));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['status'] == 'success') {
            setState(() {
              appointments = List<Map<String, dynamic>>.from(data['appointments']);
            });
          } else {
            print('Failed to load appointments: ${data['message']}');
          }
        } else {
          print('Failed to fetch appointments.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    List<Map<String, dynamic>> completedAppointments = appointments
        .where((appointment) => DateTime.parse(appointment['date']).isBefore(today))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          for (var appointment in completedAppointments)
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            appointment['service_name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            appointment['staff_name'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ScheduleCard(
                      date: appointment['date'],
                      day: DateTime.parse(appointment['date']).weekday.toString(),
                      time: appointment['time'],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                            Get.to(() => FeedbackPage());
                            },
                            child: const Text(
                              'Add Feedback',
                              style: TextStyle(color: Colors.teal),
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
    );
  }
}
