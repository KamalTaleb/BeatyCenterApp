import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  File? _image;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _noteController = TextEditingController();

  final _galleryTitleController = TextEditingController();
  final _gallerySpecialityController = TextEditingController();
  final _galleryDetailsController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.teal[700],
    ));
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image selected: ${_image!.path}');  // Debugging message
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _addStaff() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _specialtyController.text.isEmpty ||
        _noteController.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (!EmailValidator.validate(_emailController.text)) {
      _showSnackBar("Please enter a valid email address.");
      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.10/senior/add_staff.php'));
    request.fields['name'] = _nameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['password'] = _passwordController.text;
    request.fields['specialty'] = _specialtyController.text;
    request.fields['note'] = _noteController.text;
    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);

      if (jsonResponse['error'] != null && jsonResponse['error'] == "Staff member already exists") {
        _showSnackBar('Staff already exists');
      } else if (jsonResponse['success'] != null) {
        _showSnackBar('Staff added successfully');
      } else {
        _showSnackBar('Failed to add staff');
      }
    } else {
      _showSnackBar('Failed to add staff');
    }
  }

  Future<void> _deleteStaff(int id) async {
    var response = await http.get(Uri.parse('http://192.168.1.10/senior/delete_staff.php?id=$id'));
    if (response.statusCode == 200) {
      _showSnackBar('Staff deleted successfully');
    } else {
      _showSnackBar('Failed to delete staff');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchStaff() async {
    var response = await http.get(Uri.parse('http://192.168.1.10/senior/get_all_staff.php'));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> staff = List<Map<String, dynamic>>.from(json.decode(response.body));
      print("Fetched staff: $staff"); // Debugging message
      return staff;
    } else {
      throw Exception('Failed to load staff');
    }
  }

  void _showStaffOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modify Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddStaffForm();
                },
                child: Text('Add Staff', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showDeleteStaffList();
                },
                child: Text('Delete Staff', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddStaffForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _specialtyController,
                decoration: InputDecoration(labelText: 'Specialty'),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Note'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addStaff,
                child: Text('Add Staff', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteStaffList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Staff'),
          content: FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchStaff(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No staff found');
              } else {
                return SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((staff) {
                      return ListTile(
                        title: Text(staff['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            int id = int.tryParse(staff['id'].toString()) ?? 0;
                            _deleteStaff(id);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }



  Future<void> _uploadGalleryImage() async {
    if (_image != null &&
        _galleryTitleController.text.isNotEmpty &&
        _gallerySpecialityController.text.isNotEmpty &&
        _galleryDetailsController.text.isNotEmpty) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.10/senior/add_gallery_image.php'),
      );
      request.fields['title'] = _galleryTitleController.text;
      request.fields['speciality'] = _gallerySpecialityController.text;
      request.fields['details'] = _galleryDetailsController.text;
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        if (jsonResponse['success'] != null) {
          _showSnackBar('Image uploaded successfully');
        } else {
          _showSnackBar('Failed to upload image');
        }
      } else {
        _showSnackBar('Failed to upload image');
      }
    } else {
      _showSnackBar('Please fill in all fields and select an image');
    }
  }

  void _showGalleryUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Gallery Image'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _image == null
                    ? Text('No image selected.')
                    : Text('Image is selected.'),
                TextField(
                  controller: _galleryTitleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _gallerySpecialityController,
                  decoration: InputDecoration(labelText: 'Staff'),
                ),
                TextField(
                  controller: _galleryDetailsController,
                  decoration: InputDecoration(labelText: 'Details'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadGalleryImage,
                  child: Text('Upload Image', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              'Admin Panel',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _showStaffOptionsDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[400],
                            fixedSize: Size(180, 180),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Edit Staff',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            fixedSize: Size(180, 180),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Edit Services',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _showGalleryUploadDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[800],
                            fixedSize: Size(180, 180),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Edit Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[900],
                            fixedSize: Size(180, 180),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Edit Offers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
