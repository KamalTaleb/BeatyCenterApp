import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpCenter extends StatelessWidget {
  HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Text('Contact Us:'),

          SizedBox(height:10),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.teal[700],),
            title: Text('Phone'),
            subtitle: Text('+961 76 380 561'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mail,
              color: Colors.teal[700],),
            title: Text('Email'),
            subtitle: Text('sanyar.ghemrawi7@gmail.com'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.twitter,
              color: Colors.teal[700],),
            title: Text('Twitter'),
            subtitle: Text('sanyar.ghemrawi'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.whatsapp,
              color: Colors.teal[700],),
            title: Text('WhatsApp'),
            subtitle: Text('+1234567890'),
            onTap: () {
              // Handle WhatsApp tap
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.facebook,
              color: Colors.teal[700],),
            title: Text('Facebook'),
            subtitle: Text('Sanyar Ghemrawi'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.instagram,
              color: Colors.teal[700],),
            title: Text('Instagram'),
            subtitle: Text('@sanyar.ghemrawi'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
