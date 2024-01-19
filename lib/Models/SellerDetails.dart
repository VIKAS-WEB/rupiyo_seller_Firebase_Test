import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class SellerDetails {
  int? id;
  String shopName;
  //Uint8List imageBytes;
  String productCategory;
  String shopAddress;


  SellerDetails({
    this.id,
    required this.shopName,
    required this.productCategory,
    required this.shopAddress,
    //required this.imageBytes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopName': shopName,
      'productCategory': productCategory,
      'shopAddress': shopAddress,
      //'imageBytes': imageBytes,
    };
  }

  factory SellerDetails.fromMap(Map<String, dynamic> map) {
    return SellerDetails(
      id: map['id'],
      shopName: map['shopName'],
      productCategory: map['productCategory'],
      shopAddress: map['shopAddress'],
      //imageBytes: map['imageBytes'],
    );
  }
}
