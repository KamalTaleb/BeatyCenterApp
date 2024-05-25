import 'package:beauty_center/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SAppointmentPage extends StatefulWidget {
  const SAppointmentPage({super.key});

  @override
  State<SAppointmentPage> createState() => _SAppointmentPageState();
}

class _SAppointmentPageState extends State<SAppointmentPage> {
  FilterStatus status = FilterStatus.upcomming;
  Alignment _alignment = Alignment.centerLeft;

  List<dynamic> schedules = [
    {
      "staff_name": "staff 1",
      "staff_profile": "images/home1.JPG",
      "category": "hair dye",
      "status": FilterStatus.upcomming,
    },
    {
      "staff_name": "staff 2",
      "staff_profile": "images/home1.JPG",
      "category": "hair dye",
      "status": FilterStatus.complete,
    },
    {
      "staff_name": "staff 3",
      "staff_profile": "images/home1.JPG",
      "category": "hair dye",
      "status": FilterStatus.complete,
    },
    {
      "staff_name": "staff 4",
      "staff_profile": "images/home1.JPG",
      "category": "hair dye",
      "status": FilterStatus.cancel,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'upcomming':
          schedule['status'] = FilterStatus.upcomming;
          break;
        case 'complete':
          schedule['status'] = FilterStatus.complete;
          break;
        case 'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }
      return schedule['status'] == status;
    }).toList();

    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Appointment Schedule',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Config.spaceSmall,
          SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (filterStatus == FilterStatus.upcomming) {
                              status = FilterStatus.upcomming;
                              _alignment = Alignment.centerLeft;
                            } else if (filterStatus == FilterStatus.complete) {
                              status = FilterStatus.upcomming;
                              _alignment = Alignment.center;
                            } else if (filterStatus == FilterStatus.cancel) {
                              status = FilterStatus.upcomming;
                              _alignment = Alignment.centerRight;
                            }
                          },
                          child: Center(
                            child: Text(filterStatus.name),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
