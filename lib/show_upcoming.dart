import 'package:beauty_center/cancel_booking.dart';
import 'package:flutter/material.dart';

import 'package:beauty_center/staff_test.dart';
import 'package:flutter/material.dart';

//
// class SShowUPcoming extends StatefulWidget {
//   const SShowUPcoming({
//     super.key,
//     required this.buttonText,
//     required this.title,
//     required this.staffName,
//   });
//
//   final String buttonText, title, staffName;
//
//   @override
//   State<SShowUPcoming> createState() => _SShowUPcomingState();
// }
//
// class _SShowUPcomingState extends State<SShowUPcoming> {
//   bool _isSwitched = false;
//   late String buttonText, title, staffName;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Card(
//               shape: RoundedRectangleBorder(
//                 side: const BorderSide(
//                   color: Colors.transparent,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Column(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 title,
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               trailing: Switch(
//                                 value: _isSwitched,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _isSwitched = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             // Text(
//                             //   title,
//                             //   style: const TextStyle(
//                             //     color: Colors.black,
//                             //     fontWeight: FontWeight.w700,
//                             //   ),
//                             // ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               staffName,
//                               style: const TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                             child: OutlinedButton(
//                           onPressed: () {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (context) => const CancelBookingPage(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             buttonText,
//                             style: const TextStyle(color: Colors.teal),
//                           ),
//                         ))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SShowUpcoming extends StatelessWidget {
  SShowUpcoming({
    super.key,
    required this.buttonText,
    required this.title,
    required this.staffName,
  });

  final String buttonText, title, staffName;
  final ValueNotifier<bool> _isSwitched = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              staffName,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const CancelBookingPage(),
                              ),
                            );
                          },
                          child: Text(
                            buttonText,
                            style: const TextStyle(color: Colors.teal),
                          ),
                        ))
                      ],
                    )
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
