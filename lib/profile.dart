import 'dart:convert';
import 'package:beauty_center/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'sign_in.dart';
import 'edit_profile.dart';
import 'complete_profile.dart';
import 'password_manager.dart';
import 'help_center.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? userId;
  String? username;
  String? avatarUrl;

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
    if (userId != null) {
      _fetchUserDetails();
    }
  }

  Future<void> _fetchUserDetails() async {
    var url = Uri.parse("http://localhost/senior/fetch_users.php");
    var response = await http.post(url, body: {
      "user_id": userId.toString(),
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          username = data['data']['name'];
          avatarUrl = data['data']['profile_image'];
        });
      } else {
        _showSnackBar(data['error']);
      }
    } else {
      _showSnackBar("Failed to fetch user data");
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SignInPage()),
          (Route<dynamic> route) => false,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes, Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
            ),
          ],
        );
      },
    );
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
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : AssetImage('images/logo1.PNG') as ImageProvider,
                ),
                SizedBox(width: 20),
                Text(
                  username ?? 'Username',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: Icon(Icons.person_2_outlined, color: Colors.teal[700]),
                  title: Text('Your Profile'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CompleteProfile(userId: userId!),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.heart_broken_outlined, color: Colors.teal[700]),
                  title: Text('Saved'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.notification_add_outlined, color: Colors.teal[700]),
                  title: Text('Notification Settings'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.vpn_key_outlined, color: Colors.teal[700]),
                  title: Text('Password Manager'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PasswordManager(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help_outline, color: Colors.teal[700]),
                  title: Text('Help Center'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HelpCenter(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined, color: Colors.teal[700]),
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[700]),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout_rounded, color: Colors.teal[700]),
                  title: Text('Log out'),
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
