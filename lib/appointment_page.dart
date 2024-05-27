import 'package:beauty_center/enums.dart';
import 'package:flutter/material.dart';

class SAppointmentPage extends StatefulWidget {
  const SAppointmentPage({super.key});

  @override
  State<SAppointmentPage> createState() => _SAppointmentPageState();
}

class _SAppointmentPageState extends State<SAppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;

  // Alignment _alignment = Alignment.centerLeft;

  List<dynamic> schedules = [
    {
      "staff_name": "staff 1",
      "staff_profile": "images/home1.JPG",
      "category": "hair dye",
      "status": FilterStatus.upcoming,
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
        case 'upcoming':
          schedule['status'] = FilterStatus.upcoming;
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
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
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
            const SizedBox(
              height: 25,
            ),
            // Stack(
            //   children: [
            //     Container(
            //       width: double.infinity,
            //       height: 40,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(20.0),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           for (FilterStatus filterStatus in FilterStatus.values)
            //             Expanded(
            //               child: GestureDetector(
            //                 onTap: () {
            //                   if (filterStatus == FilterStatus.upcoming) {
            //                     status = FilterStatus.upcoming;
            //                     _alignment = Alignment.centerLeft;
            //                   } else if (filterStatus ==
            //                       FilterStatus.complete) {
            //                     status = FilterStatus.complete;
            //                     _alignment = Alignment.center;
            //                   } else if (filterStatus == FilterStatus.cancel) {
            //                     status = FilterStatus.cancel;
            //                     _alignment = Alignment.centerRight;
            //                   }
            //                 },
            //                 child: Center(
            //                   child: Text(filterStatus.name),
            //                 ),
            //               ),
            //             ),
            //         ],
            //       ),
            //     ),
            //     AnimatedAlign(
            //       alignment: _alignment,
            //       duration: const Duration(milliseconds: 200),
            //       child: Container(
            //         width: 100,
            //         height: 40,
            //         decoration: BoxDecoration(
            //           color: Colors.greenAccent,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Center(
            //           child: Text(
            //             status.name,
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index) {
                  var schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(schedule['staff_profile']),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule['staff_name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    schedule['category'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const ScheduleCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: OutlinedButton(
                                onPressed: () {},
                                child: const Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key,
      this.date = "11/18/2024",
      this.day = "Monday",
      this.time = "2:00 PM"})
      : super(key: key);
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
            color: Colors.greenAccent,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(
              color: Colors.greenAccent,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.greenAccent,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            time,
            style: const TextStyle(
              color: Colors.greenAccent,
            ),
          ))
        ],
      ),
    );
  }
}
