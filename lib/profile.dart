import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/logo1.PNG'),
                ),
                SizedBox(width: 20),
                Text('Username', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: const Icon(Icons.person_2_outlined),
                  title: const Text('Your Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CompleteProfile(userId: userId!),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.heart_broken_outlined),
                  title: const Text('Saved'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notification_add_outlined),
                  title: const Text('Notification Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.vpn_key_outlined),
                  title: const Text('Password Manager'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help Center'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Log out'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
