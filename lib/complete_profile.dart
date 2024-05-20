import 'dart:convert';
import 'package:beauty_center/home.dart';
import 'package:beauty_center/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class completePage extends StatefulWidget {
  final int userId;

  const completePage({super.key, required this.userId});

  @override
  State<completePage> createState() => _completePageState();
}

class _completePageState extends State<completePage> {
  late String _selectedItem = "Male";
  TextEditingController phoneNumberController = TextEditingController();
  Uint8List? _image;
  File? selectedImage;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.teal[700],
    ));
  }

  Future<void> completeProfile() async {
    if (phoneNumberController.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    var url = Uri.parse("http://localhost/senior/complete_profile.php");
    var request = http.MultipartRequest("POST", url);
    request.fields['user_id'] = widget.userId.toString();
    request.fields['phone'] = phoneNumberController.text;
    request.fields['gender'] = _selectedItem;

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_image', selectedImage!.path));
    }

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("Response data: $responseData"); // Log the response data
      var data = json.decode(responseData);

      if (response.statusCode == 200 && data.containsKey("success")) {
        _showSnackBar(data["success"]);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => homePage()),
        );
      } else {
        _showSnackBar(data["error"] ?? "Unknown error occurred.");
      }
    } catch (e) {
      print("Exception: $e"); // Log the exception
      _showSnackBar("Failed to complete profile. Please try again later.");
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
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Complete Your Profile",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                        radius: 100, backgroundImage: MemoryImage(_image!))
                        : const CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          "https://images.app.goo.gl/7KgwNKcb19njWod3A"),
                    ),
                    Positioned(
                      bottom: -0,
                      left: 140,
                      child: IconButton(
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: "Phone number",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Prefer not to answer',
                            child: Text('Prefer not to answer'),
                          ),
                        ],
                        onSelected: (String value) {
                          setState(() {
                            _selectedItem = value;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: _selectedItem),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      onPressed: completeProfile,
                      color: Colors.teal.shade700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Complete Profile",
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
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      Navigator.of(context).pop();
    });
  }

  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      Navigator.of(context).pop();
    });
  }
}
