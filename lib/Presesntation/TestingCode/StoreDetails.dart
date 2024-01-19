import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellerDetailsPageTrial extends StatefulWidget {
  @override
  _SellerDetailsPageTrialState createState() => _SellerDetailsPageTrialState();
}

class _SellerDetailsPageTrialState extends State<SellerDetailsPageTrial> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController productCategoriesController = TextEditingController();
  List<XFile>? photos;

  Future<void> _selectPhotos() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedPhotos = await _picker.pickMultiImage();

    if (selectedPhotos != null) {
      setState(() {
        photos = selectedPhotos;
      });
    }
  }

  Future<void> _submitForm() async {
    final String shopName = shopNameController.text;
    final String productCategories = productCategoriesController.text;

    // Convert the list of XFile to a list of bytes (base64 encoded images)
    final List<String> base64Images = photos?.map((photo) {
          List<int> imageBytes = File(photo.path).readAsBytesSync();
          return base64Encode(imageBytes);
        }).toList() ??
        [];

    // Replace with your PHP server endpoint
    final String serverEndpoint = 'http://192.168.1.41/RUPIYOSELLER_API/save_seller_details.php';

    try {
      final response = await http.post(
        headers: {'Accept': 'application/json'},
        Uri.parse(serverEndpoint),
        body: {
          'shopName': shopName,
          'productCategories': productCategories,
          'photos': jsonEncode(base64Images),
        },
      );

      if (response.statusCode == 200) {
        // Successfully saved to the database
        print('Seller details saved successfully');
      } else {
        // Handle errors here
        print(
            'Error saving seller details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Details Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: shopNameController,
              decoration: const InputDecoration(labelText: 'Shop Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: productCategoriesController,
              decoration:
                  const InputDecoration(labelText: 'Product Categories'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectPhotos,
              child: const Text('Upload Shop Photos'),
            ),
            const SizedBox(height: 16),
            if (photos != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Upload Shop Photos'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: photos!.map((photo) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(photo.path)),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
