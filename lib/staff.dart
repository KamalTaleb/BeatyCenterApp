import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StaffSchedulePage extends StatefulWidget {
  @override
  _StaffSchedulePageState createState() => _StaffSchedulePageState();
}

class _StaffSchedulePageState extends State<StaffSchedulePage> {
  List<dynamic> schedule = [];
  bool isLoading = true;
  String staffName = "";

  @override
  void initState() {
    super.initState();
    _fetchSchedule();
  }

  Future<void> _fetchSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? staffId = prefs.getInt('user_id');
    staffName = prefs.getString('staff_name') ?? "Staff";

    if (staffId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://172.20.10.5/senior/get_staff_schedule.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'staffId': staffId}),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            schedule = data['schedule'];
            isLoading = false;
          });
        } else {
          print('Error: ${data['message']}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to load schedule. Response code: ${response.statusCode}. Response body: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching schedule: $e');
      print('Exception details: ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$staffName\'s Schedule'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : schedule.isEmpty
          ? const Center(child: Text('No appointments found'))
          : ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final appointment = schedule[index];
          return ListTile(
            title: Text(appointment['service']),
            subtitle: Text('Date: ${appointment['date']} Time: ${appointment['time']}'),
          );
        },
      ),
    );
  }
}
