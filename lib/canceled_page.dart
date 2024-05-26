import 'package:beauty_center/add_feedback.dart';
import 'package:beauty_center/scheduled_card.dart';
import 'package:flutter/material.dart';

class SCanceledPage extends StatefulWidget {
  const SCanceledPage({
    super.key,
  });

  @override
  State<SCanceledPage> createState() => _SCanceledPageState();
}

class _SCanceledPageState extends State<SCanceledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
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
                  const Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Service Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Staff Name',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => FeedbackPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Re-Book',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
