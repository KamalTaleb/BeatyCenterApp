import 'package:beauty_center/custom/appBar/custom_appbar.dart';
import 'package:beauty_center/custom/button.dart';
import 'package:beauty_center/screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SBookingCalendarPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedServices;
  final Map<int, Map<String, String>> selectedStaffForServices;
  final int? userId;

  const SBookingCalendarPage({
    super.key,
    required this.selectedServices,
    required this.selectedStaffForServices,
    required this.userId,
  });

  @override
  State<SBookingCalendarPage> createState() => _SBookingCalendarPageState();
}

class _SBookingCalendarPageState extends State<SBookingCalendarPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  Map<DateTime, Set<int>> _bookedTimes = {};
  DateTime? _selectedDate;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchBookedTimes(int staffId, DateTime date) async {
    var url = Uri.parse('http://172.20.10.5/senior/get_booked_times.php');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'staff_id': staffId,
          'date': date.toIso8601String().split('T')[0],
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> times = json.decode(response.body);
        setState(() {
          _bookedTimes[date] = times.map((time) => int.parse(time.split(':')[0]) - 9).toSet();
        });
      } else {
        print('Failed to fetch booked times: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching booked times: $e');
    }
  }

  String _formatTime(int hour) {
    final h = hour > 12 ? hour - 12 : hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    return '${h.toString().padLeft(2, '0')}:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Iconsax.arrow_left),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Appointment Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Unfortunately, we are not available on weekends, please choose another day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
              : SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                bool isBooked = _bookedTimes[_currentDay]?.contains(index) ?? false;
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: isBooked
                      ? null
                      : () {
                    setState(() {
                      _currentIndex = index;
                      _timeSelected = true;
                      _selectedDate = _currentDay;
                      _selectedTime = _formatTime(index + 9);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isBooked
                            ? Colors.grey
                            : _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: isBooked
                          ? Colors.grey
                          : _currentIndex == index
                          ? Colors.teal[700]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 9}:00 ${index + 9 >= 12 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isBooked
                            ? Colors.white
                            : _currentIndex == index
                            ? Colors.white
                            : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 80,
              ),
              child: SButton(
                width: double.infinity,
                title: 'Checkout',
                onPressed: () async {
                  await _saveAppointmentSelection();
                  if (_currentIndex != null) {
                    setState(() {
                      _bookedTimes[_currentDay] ??= {};
                      _bookedTimes[_currentDay]!.add(_currentIndex!);
                      _timeSelected = false;
                      _dateSelected = false;
                      _currentIndex = null;
                    });
                  }
                  Get.to(() => SCheckoutScreen(
                    selectedServices: widget.selectedServices,
                    selectedStaffForServices: widget.selectedStaffForServices,
                    selectedDate: _selectedDate!,
                    selectedTime: _selectedTime!,
                  ));
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.teal,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusDay) async {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusDay;
          _dateSelected = true;
          _currentIndex = null;
          _timeSelected = false;
          _isWeekend = selectedDay.weekday == 6 || selectedDay.weekday == 7;
        });

        if (!_isWeekend) {
          for (var service in widget.selectedServices) {
            final staffDetails = widget.selectedStaffForServices[service['id']];
            if (staffDetails != null) {
              await _fetchBookedTimes(int.parse(staffDetails['id']!), selectedDay);
            }
          }
        }
      },
    );
  }

  Future<void> _saveAppointmentSelection() async {
    if (widget.userId == null || _selectedDate == null || _selectedTime == null) {
      print('Required data is not available');
      return;
    }

    var url = Uri.parse('http://172.20.10.5/senior/save_appointment.php');
    try {
      for (var service in widget.selectedServices) {
        final staffDetails = widget.selectedStaffForServices[service['id']];
        if (staffDetails != null) {
          var response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'user_id': widget.userId,
              'service_id': service['id'],
              'staff_id': staffDetails['id'],
              'date': _selectedDate!.toIso8601String().split('T')[0],
              'time': _selectedTime,
            }),
          );

          print('Sending appointment data to the server');
          if (response.statusCode == 200) {
            print('Appointment saved successfully');
            print('Response: ${response.body}');
          } else {
            print('Failed to save appointment: ${response.statusCode} - ${response.body}');
          }
        } else {
          print('No staff selected for service ID: ${service['id']}');
        }
      }
    } catch (e) {
      print('Error saving appointment: $e');
    }
  }
}
