// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rupiyo_seller/Database/DatabaseHelper.dart';
// import 'package:rupiyo_seller/Models/SellerDetails.dart';
// import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

// class SellersDataTest extends StatefulWidget {
//   const SellersDataTest({super.key});

//   @override
//   State<SellersDataTest> createState() => _SellersDataTestState();
// }

// class _SellersDataTestState extends State<SellersDataTest> {
//   final Map<String, TextEditingController> controllers = {};
//   PickedFile? _pickedImage;
//   DatabaseHelper _databaseHelper = DatabaseHelper();
//   // Track whether data is currently being loaded
//   bool isLoading = false;

//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _productCategoryController =
//       TextEditingController();
//   final TextEditingController _shopAddressController = TextEditingController();

//   List<SellerDetails> sellerDetailsList = [];
//   @override
//   void initState() {
//     super.initState();
//     _loadSellerDetails();
//   }

//   void _loadSellerDetails() async {
//     List<SellerDetails> sellers = await _databaseHelper.getAllSellerDetails();
//     setState(() {
//       sellerDetailsList = sellers;
//     });
//   }

//   void submitForm() async {
//     Uint8List imageBytes = _pickedImage != null
//         ? await _getImageBytes(_pickedImage!)
//         : Uint8List(0);

//     // Insert a SellerDetails record
//     SellerDetails sellerDetails = SellerDetails(
//       shopName: _shopNameController.text,
//       productCategory: _productCategoryController.text,
//       shopAddress: _shopAddressController.text,
//       //imageBytes: imageBytes,
//     );
//     int insertedId = await _databaseHelper.insertSellerDetails(sellerDetails);
//     print('SellerDetails inserted with ID: $insertedId');
//     void _loadSellerDetails() async {
//       List<SellerDetails> sellers = await _databaseHelper.getAllSellerDetails();
//       setState(() {
//         sellerDetailsList = sellers;
//       });
//     }

//     // Clear text fields and picked image after insertion
//     _shopNameController.clear();
//     _productCategoryController.clear();
//     _shopAddressController.clear();
//     setState(() {
//       _pickedImage = null;
//     });
//   }

//   Future<Uint8List> _getImageBytes(PickedFile pickedImage) async {
//     try {
//       File imageFile = File(pickedImage.path);
//       Uint8List bytes = await imageFile.readAsBytes();
//       return bytes;
//     } catch (e) {
//       print('Error decoding image: $e');
//       return Uint8List(0);
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedImage =
//         await ImagePicker().getImage(source: ImageSource.gallery);
//     setState(() {
//       _pickedImage = pickedImage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SQLite Database Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//               ),
//               TextFormField(
//                 controller: _productCategoryController,
//                 decoration: InputDecoration(labelText: 'Product Category'),
//               ),
//               TextFormField(
//                 controller: _shopAddressController,
//                 decoration: InputDecoration(labelText: 'Shop Address'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Pick Image'),
//               ),
//               _pickedImage != null
//                   ? Image.file(
//                       File(_pickedImage!.path),
//                       height: 100,
//                       width: 100,
//                     )
//                   : SizedBox.shrink(),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: submitForm,
//                 child: Text('Submit'),
//               ),
//                SizedBox(height: 20),
//             Text('Inserted SellerDetails:'),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: sellerDetailsList.length,
//                 itemBuilder: (context, index) {
//                   SellerDetails sellerDetails = sellerDetailsList[index];
//                   return ListTile(
//                     title: Text('Shop Name: ${sellerDetails.shopName}'),
//                     subtitle: Text('Product Category: ${sellerDetails.productCategory}'),
//                     // trailing: Image.memory(
//                     //   sellerDetails.imageBytes,
//                     //   errorBuilder: (context, error, stackTrace) {
//                     //     print('Error loading image: $error');
//                     //     return Icon(Icons.error);
//                     //   },
//                     // ),
//                   );
//                 }
//               ),
//             )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future SuccessDialog() => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             elevation: 0,
//             backgroundColor: AppColor.BackgroundColor,
//             content: Container(
//               color: AppColor.BackgroundColor,
//               height: 300,
//               child: Column(
//                 children: [
//                   const Text(
//                     'Successfully Added Shop Name',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: 200,
//                     child: Lottie.asset(
//                       'Assets/LottieAssets/Success.json',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ));
// }
