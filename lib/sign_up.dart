import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:beauty_center/complete_profile.dart';
import 'package:beauty_center/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // EmailOTP myauth = EmailOTP();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.teal[700],
    ));
  }

  Future<void> signup() async {
    if (email.text.isEmpty || password.text.isEmpty || name.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (!EmailValidator.validate(email.text)) {
      _showSnackBar("Please enter a valid email address.");
      return;
    }

    var url = Uri.parse("http://localhost/senior/register.php");
    var response = await http.post(url, body: {
      "name": name.text,
      "email": email.text,
      "password": password.text,
    });

    print(response.body);

    var data = json.decode(response.body);
    if (data.containsKey("error")) {
      _showSnackBar(data["error"]);
    } else if (data.containsKey("success")) {
      if (data.containsKey('user_id') && data['user_id'] != null) {
        int userId = data['user_id'];
        // myauth.setConfig(
        //   appEmail: "52210183@students.liu..edu.lb",
        //   appName: "Email OTP",
        //   userEmail: email.text,
        //   otpLength: 4,
        //   otpType: OTPType.digitsOnly,
        // );
        // if (await myauth.sendOTP()) {
        //   _showSnackBar("OTP has been sent");
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => VerificationScreen(myauth: myauth, email: email.text),
        //     ),
        //   );
        // } else {
        //   _showSnackBar("Oops, OTP send failed");
        // }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => completePage(userId: userId),
          ),
        );
      } else {
        _showSnackBar("User ID is missing from the response.");
      }
    } else {
      _showSnackBar("Unexpected response format. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Fill your information below or register with your social account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: password,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: _toggleVisibility,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: signup,
                  color: Colors.teal.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.teal.shade700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
