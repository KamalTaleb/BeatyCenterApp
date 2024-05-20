import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:beauty_center/complete_profile.dart';

class VerificationScreen extends StatefulWidget {
  final EmailOTP myauth;
  final String email;

  VerificationScreen({required this.myauth, required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.teal[700],
    ));
  }

  void verifyOTP() async {
    String otp = _controller1.text + _controller2.text + _controller3.text + _controller4.text;
    bool result = await widget.myauth.verifyOTP(otp: otp);
    if (result) {
      _showSnackBar("OTP is verified");
    } else {
      _showSnackBar("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify Code',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please enter the code we sent to your email',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controller1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controller2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controller3,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    controller: _controller4,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counter: Offstage(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            TextButton(
              onPressed: () {
                widget.myauth.sendOTP();
                _showSnackBar('OTP has been resent');
              },
              child: Text(
                'Resend Code',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: verifyOTP,
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
