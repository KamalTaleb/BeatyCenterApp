import 'dart:convert';
import 'package:beauty_center/help_center.dart';
import 'package:beauty_center/privacy_policy.dart';
import 'package:beauty_center/saved.dart';
import 'package:beauty_center/screens/password_manager.dart';
import 'package:beauty_center/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data'; // Import for Uint8List
import '../edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? userId;
  String? username;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    if (userId != null) {
      await _fetchUserData(userId!);
    }
  }

  Future<void> _fetchUserData(int userId) async {
    var url = Uri.parse("http://172.20.10.5/senior/fetch_users.php");
    var response = await http.post(url, body: {
      "user_id": userId.toString(),
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          username = data['data']['name'];
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

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    Get.offAll(() => SignInPage());
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.teal[700])),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Yes, Logout', style: TextStyle(color: Colors.teal[700])),
              onPressed: () {
                Get.back();
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
    centerTitle: true,
    ),
    body: userId == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: profileImage != null
                    ? MemoryImage(profileImage!)
                    : const AssetImage('images/logo1.PNG')
                as ImageProvider,
              ),
              const SizedBox(width: 20),
              Text(username ?? 'Username',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              ListTile(
                leading: Icon(Icons.person_outline, color: Colors.teal[700]),
                title: const Text('Your Profile'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () {
                  if (userId != null) {
                    Get.off(() => editProfile(userId: userId!));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User ID is not available.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.heart_broken_outlined, color: Colors.teal[700]),
                title: const Text('Saved'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () => Get.to(() => SavedImages()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.notifications_outlined, color: Colors.teal[700]),
                title: const Text('Notification Settings'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () => Get.to(() => HelpCenter()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.vpn_key_outlined, color: Colors.teal[700]),
                title: const Text('Password Manager'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () => Get.to(() => PasswordManager()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.teal[700]),
                title: const Text('Help Center'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () => Get.to(() => HelpCenter()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined, color: Colors.teal[700]),
                title: const Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: () => Get.to(() => PrivacyPolicyPage()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.teal[700]),
                title: const Text('Log out'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                onTap: _showLogoutDialog,
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
