import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:rupiyo_seller/Presesntation/TestingCode/FetchProductDetails.dart';

class ProductListings extends StatefulWidget {
  const ProductListings({super.key});

  @override
  State<ProductListings> createState() => _ProductListingsState();
}

class _ProductListingsState extends State<ProductListings> {
  TextEditingController ProductnameController = TextEditingController();
  TextEditingController ProductDescriptionController = TextEditingController();
  TextEditingController ProductPriceController = TextEditingController();
  TextEditingController ProductCategoryController = TextEditingController();

  File? selectedImage;

  List<File?> selectedImages = [];

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       selectedImages.add(File(pickedFile.path));
  //     });
  //   }
  // }

  Future<void> _uploadData() async {
    String name = ProductnameController.text.trim();
    String description = ProductDescriptionController.text.trim();
    String price = ProductPriceController.text.trim();
    String Category = ProductCategoryController.text.trim();

    if (name.isNotEmpty &&
        description.isNotEmpty &&
        price.isNotEmpty &&
        Category.isEmpty) {
      print('Name: $name');
      print('Description: $description');
      print('Price: $price');
      print('Selected Category: $selectedCategory');
      //print('Selected Image: ${selectedImage!.path}');
      try {
        var uri = Uri.parse(
            "http://192.168.1.41/RUPIYOSELLER_API/AddProdcuts.php"); // Replace with your actual server URL

        var request = http.MultipartRequest('POST', uri)
          ..fields['ProductName'] = name
          ..fields['Description'] = description
          ..fields['price'] = price
          ..fields['category'] = selectedCategory
          ..files.add(http.MultipartFile(
            'image_path',
            selectedImage!.readAsBytes().asStream(),
            selectedImage!.lengthSync(),
            filename: 'image.jpg',
          ));

        var response = await request.send();

        if (response.statusCode == 200) {
          print('Data uploaded successfully');
          // Optionally, you can reset the form or perform other actions upon successful upload.
        } else {
          print('Failed to upload data. Status Code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error uploading data: $e');
      }
    } else {
      print('Please fill in all details and select an image.');
    }
  }

  List<String> categories = [
    'Fruits&Vegitables',
    'Atta',
    'Masala',
    'sweet',
    'FrozenFood',
    'packaged Items',
    'DairyBread',
    'Meats,Fish And Eggs',
    'BreakFast And Sauces',
    'Tea, Cofee And More',
    'Biscuits',
    'Makeup And Beauty',
    'Meats & Seafood',
    'KitchenNeeds',
    'petcare',
    'PartyEssential',
    'Fitness',
    'OrganicFood',
    'BabyCare',
  ];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    // Set a default value for the dropdown
    selectedCategory = categories.isNotEmpty ? categories.first : '';
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  TextEditingController _rupeeController = TextEditingController();

  List<File> _imageList = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        leading: const Icon(
          CupertinoIcons.back,
          color: AppColor.BackgroundColor,
        ),
        title: const Text(
          'Product Listing',
          style: TextStyle(color: AppColor.BackgroundColor),
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Add Your Product',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: AppColor.textColor, blurRadius: 6)
                          ],
                          color: AppColor.BackgroundColor,
                          borderRadius: BorderRadius.circular(25)),
                      height: 60,
                      width: 340,
                      child: TextFormField(
                        controller: ProductnameController,
                        decoration: const InputDecoration(
                            labelText: 'Product Name',
                            hintText: 'Enter your Product Name',
                            hintStyle: TextStyle(fontSize: 12),
                            prefixIcon: Icon(CupertinoIcons.cube_box_fill),
                            border: InputBorder.none),
                        style: const TextStyle(fontSize: 16.0),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Product Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: AppColor.textColor, blurRadius: 8)
                          ],
                          color: AppColor.BackgroundColor,
                          borderRadius: BorderRadius.circular(25)),
                      height: 60,
                      width: 340,
                      child: TextFormField(
                        controller: ProductDescriptionController,
                        decoration: const InputDecoration(
                            labelText: 'Product Description',
                            //hintText: 'Enter your Product Description',
                            hintMaxLines: 2,
                            prefixIcon: Icon(
                                CupertinoIcons.exclamationmark_bubble_fill),
                            border: InputBorder.none),
                        style: const TextStyle(fontSize: 16.0),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Product Description.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 30),
                    //       child: Text(
                    //         'Enter Product Price',
                    //         style: TextStyle(fontSize: 16, color: Colors.black),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColor.textColor, blurRadius: 8)
                              ],
                              color: AppColor.BackgroundColor,
                              borderRadius: BorderRadius.circular(25)),
                          height: 55,
                          width: 340,
                          child: TextFormField(
                            controller: ProductPriceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                                labelText: 'Product Price',
                                hintText: 'Enter your Product Price',
                                hintStyle: TextStyle(fontSize: 12),
                                hintMaxLines: 2,
                                prefixIcon: Icon(Icons.currency_rupee_outlined),
                                border: InputBorder.none),
                            style: const TextStyle(fontSize: 16.0),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Product Description.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Select Your Product Category',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.textColor, blurRadius: 6)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                color: AppColor.BackgroundColor),
                            width: 330,
                            height: 53,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 3),
                              child: DropdownSearch<String>(
                                items: categories,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                border: InputBorder.none)),
                                popupProps: const PopupProps.bottomSheet(
                                    bottomSheetProps: BottomSheetProps(
                                        backgroundColor: Colors.white,
                                        elevation: 0)),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                                selectedItem: selectedCategory,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            'Add Product Images',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => _pickImages(),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black),
                        ),
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Icon(Icons.add,
                                    size: 50, color: Colors.black),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.mainColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // await Future.delayed(Duration(seconds: 2));
                                setState(() {
                                  isLoading = true;
                                });
                                _uploadData();
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: const Duration(milliseconds: 200),
                                    type: PageTransitionType.leftToRight,
                                    child: const FetchProductDetails(),
                                  ),
                                );
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                print('Please Fill In All Details');
                              }
                            },
                            child: const Center(
                                child: Text(
                              'Add',
                              style: TextStyle(
                                  color: AppColor.BackgroundColor,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ))),
    );
  }
}
