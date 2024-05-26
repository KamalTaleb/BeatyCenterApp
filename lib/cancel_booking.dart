import 'package:beauty_center/navigation_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CancelBookingPage extends StatefulWidget {
  const CancelBookingPage({super.key});

  @override
  _CancelBookingPageState createState() => _CancelBookingPageState();
}

class _CancelBookingPageState extends State<CancelBookingPage> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  void _cancelBooking() {
    String reason = _selectedReason ?? 'Other: ${_otherReasonController.text}';
    if (kDebugMode) {
      print('Booking cancelled due to: $reason');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Booking'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavigationMenu(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please select the reason for cancellation:',
              style: TextStyle(fontSize: 16, color: Colors.black45),
            ),
            const SizedBox(height: 10),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: Text('Scheduling Conflicts'),
              value: 'Scheduling Conflicts',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Health Issues'),
              value: 'Health Issues',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Personal Reasons'),
              value: 'Personal Reasons',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Financial Constraints'),
              value: 'Financial Constraints',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Weather Conditions'),
              value: 'Weather Conditions',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Dissatisfaction with Service'),
              value: 'Dissatisfaction with Service',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[700],
              title: const Text('Other reasons'),
              value: 'Other reasons',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  _otherReasonController.clear();
                });
              },
            ),
            if (_selectedReason == 'Other reasons')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _otherReasonController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _cancelBooking,
                child: const Text('Cancel Booking',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
