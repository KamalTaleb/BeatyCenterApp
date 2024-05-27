import 'dart:convert';
import 'package:beauty_center/screens/profile.dart';
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
    var url = Uri.parse("http://192.168.1.9/senior/fetch_users.php");
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
            profileImage = base64Decode(data['data']['profile_image']);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['error']),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Your profile',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: profileImage != null
                  ? MemoryImage(profileImage!)
                  : const AssetImage('assets/avatar.jpg') as ImageProvider,
            ),
            TextField(
              controller: nameController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
              value: gender,
              items: const [
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
