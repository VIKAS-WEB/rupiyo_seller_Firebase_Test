// data_provider.dart
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Models/SellerDetails.dart';

class DataProvider extends ChangeNotifier {
  List<SellerDetails> _dataList = [];

  List<SellerDetails> get dataList => _dataList;

  void addData(SellerDetails data) {
    // Add the data to the list
    _dataList.add(data);

    // Notify listeners to update the UI
    notifyListeners();
  }
}
