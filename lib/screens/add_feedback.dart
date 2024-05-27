import 'package:beauty_center/screens/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String? _selectedRating;
  final TextEditingController _feedbackController = TextEditingController();
  PlatformFile? _selectedFile;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  void _submitFeedback() {
    // Add your feedback submission logic here
    String rating = _selectedRating ?? 'No rating selected';
    String feedback = _feedbackController.text;
    String fileName = _selectedFile?.name ?? 'No file selected';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add feedback'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavigationMenu(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildRatingRadio('4.5 and above', 4.5),
            _buildRatingRadio('4.0 - 4.5', 4.0),
            _buildRatingRadio('3.5 - 4.0', 3.5),
            _buildRatingRadio('3.0 - 3.5', 3.0),
            _buildRatingRadio('2.5 - 3.0', 2.5),
            const SizedBox(height: 20),
            const Text(
              'Add Feedback',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'File Upload',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: _selectedFile == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 50,
                              color: Colors.teal[700],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Drag Files to Upload or Browse Files',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          _selectedFile!.name,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
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
                onPressed: _submitFeedback,
                color: Colors.teal.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Submit Feedback",
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
      ),
    );
  }

  Widget _buildRatingRadio(String rating, double starCount) {
    return RadioListTile<String>(
      title: Row(
        children: [
          RatingBarIndicator(
            rating: starCount,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.teal[700],
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          const SizedBox(width: 10),
          Text(rating),
        ],
      ),
      value: rating,
      groupValue: _selectedRating,
      activeColor: Colors.teal[700],
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (value) {
        setState(() {
          _selectedRating = value;
        });
      },
    );
  }
}
