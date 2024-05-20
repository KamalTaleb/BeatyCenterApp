import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // Import for Uint8List

class CompleteProfile extends StatefulWidget {
  final int userId;

  const CompleteProfile({super.key, required this.userId});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? gender;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var url = Uri.parse("http://localhost/senior/fetch_users.php");
    var response = await http.post(url, body: {
      "user_id": widget.userId.toString(),
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          nameController.text = data['data']['name'];
          phoneNumberController.text = data['data']['phone'];
          gender = data['data']['gender'];
          if (data['data']['profile_image'] != null) {
            profileImage = Base64Decoder().convert(data['data']['profile_image']);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['error']),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch user data"),
        backgroundColor: Colors.red,
      ));
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
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your profile',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: profileImage != null
                  ? MemoryImage(profileImage!)
                  : AssetImage('assets/avatar.jpg') as ImageProvider,
            ),
            TextField(
              controller: nameController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
              value: gender,
              items: [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text('Female'),
                ),
              ],
              onChanged: (String? newValue) {
                // Gender selection is not editable
              },
            ),
          ],
        ),
      ),
    );
  }
}
