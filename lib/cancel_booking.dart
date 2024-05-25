import 'package:flutter/material.dart';

class CancelBookingPage extends StatefulWidget {
  @override
  _CancelBookingPageState createState() => _CancelBookingPageState();
}

class _CancelBookingPageState extends State<CancelBookingPage> {
  String? _selectedReason;
  TextEditingController _otherReasonController = TextEditingController();

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  void _cancelBooking() {
    String reason = _selectedReason ?? 'Other: ${_otherReasonController.text}';
    print('Booking cancelled due to: $reason');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Booking'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please select the reason for cancellation:',
              style: TextStyle(fontSize: 16, color: Colors.black45),
            ),
            SizedBox(height: 10),
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
              title: Text('Health Issues'),
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
              title: Text('Personal Reasons'),
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
              title: Text('Financial Constraints'),
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
              title: Text('Weather Conditions'),
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
              title: Text('Dissatisfaction with Service'),
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
              title: Text('Other reasons'),
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
                  decoration: InputDecoration(
                    labelText: 'Enter your Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _cancelBooking,
                child: Text('Cancel Booking', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
