import 'package:flutter/material.dart';

class SUpcommingPage extends StatefulWidget {
  const SUpcommingPage({super.key});

  @override
  State<SUpcommingPage> createState() => _SUpcommingPageState();
}

class _SUpcommingPageState extends State<SUpcommingPage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListTile(
                title: const Text('Date and time'),
                trailing: Switch(
                  value: _isSwitched,
                  onChanged: (value){
                    setState(() {
                      _isSwitched=value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: const Text('Appointment details'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
