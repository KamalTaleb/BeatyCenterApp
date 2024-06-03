import 'package:beauty_center/screens/cancel_booking.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class SUpcomingPage extends StatefulWidget {
  const SUpcomingPage({super.key});

  @override
  State<SUpcomingPage> createState() => _SUpcomingPageState();
}

class _SUpcomingPageState extends State<SUpcomingPage> {
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

    List<Map<String, dynamic>> upcomingAppointments = appointments
        .where((appointment) => DateTime.parse(appointment['date']).isAfter(today))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            for (var appointment in upcomingAppointments)
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
                                Get.to(() => CancelBookingPage(appointmentId: int.parse(appointment['id'])));
                              },
                              child: const Text(
                                'Cancel',
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
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.date,
    required this.day,
    required this.time,
  });

  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.teal,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.teal,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
