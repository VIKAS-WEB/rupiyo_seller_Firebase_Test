import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  late File _image;
  String _errorMessage = '';

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error picking image: $e';
      });
    }
  }

  // Function to upload the selected image (you need to implement the server-side logic)
  Future<void> _uploadImage() async {
    try {
      // Check if _image is null before trying to upload
      if (_image != null) {
        // TODO: Implement your server-side logic to handle image upload
        // You can use a package like http or dio to send the image to the server
        // Example: http.post('your_upload_endpoint', body: {'image': _image.readAsBytesSync()});
        print('Image path: ${_image.path}');
        _errorMessage = ''; // Reset error message if successful
      } else {
        setState(() {
          _errorMessage = 'No image selected';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error uploading image: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null ? Image.file(_image) : Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
