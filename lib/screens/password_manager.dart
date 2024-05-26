import 'dart:convert';
import 'package:beauty_center/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PasswordManager extends StatefulWidget {
  PasswordManager({Key? key}) : super(key: key);

  @override
  _PasswordManagerState createState() {
    return _PasswordManagerState();
  }
}

class _PasswordManagerState extends State<PasswordManager> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });
  }

  List<String> _validatePassword(String password) {
    List<String> errors = [];
    if (password.length < 8) {
      errors.add("Password must be at least 8 characters long.");
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("Password must include at least one uppercase letter.");
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("Password must include at least one lowercase letter.");
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add("Password must include at least one digit.");
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      errors.add("Password must include at least one special character.");
    }
    return errors;
  }

  Future<void> _changePassword() async {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (newPasswordController.text != confirmNewPasswordController.text) {
      _showSnackBar("New password and confirm password do not match.");
      return;
    }

    List<String> passwordErrors = _validatePassword(newPasswordController.text);
    if (passwordErrors.isNotEmpty) {
      for (var error in passwordErrors) {
        _showSnackBar(error);
      }
      return;
    }

    var url = Uri.parse("http://192.168.1.12/senior/new_password.php");
    var response = await http.post(url, body: {
      "user_id": userId.toString(),
      "current_password": currentPasswordController.text,
      "new_password": newPasswordController.text,
    });

    var data = json.decode(response.body);
    if (data.containsKey("success")) {
      _showSnackBar(data["success"]);
    } else {
      _showSnackBar(data["error"] ?? "An error occurred.");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.teal[700],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Password Manager',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              }),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: confirmNewPasswordController,
                obscureText: _obscureConfirmNewPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmNewPassword =
                            !_obscureConfirmNewPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: _changePassword,
                  color: Colors.teal.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
