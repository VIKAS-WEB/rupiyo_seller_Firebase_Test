import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class FetchProductDetails extends StatefulWidget {
  const FetchProductDetails({Key? key}) : super(key: key);

  @override
  State<FetchProductDetails> createState() => _FetchProductDetailsState();
}

class _FetchProductDetailsState extends State<FetchProductDetails> {
  List<Map<String, dynamic>> products = [];
  bool isRefreshing = false;

  Future<void> _fetchProducts() async {
    try {
      var uri = Uri.parse(
          "http://192.168.1.41/RUPIYOSELLER_API/FetchProductsDetails.php");
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        // Parse the JSON response
        var data = json.decode(response.body);
        if (data is List) {
          setState(() {
            products = List<Map<String, dynamic>>.from(data);
          });
        }
      } else {
        print('Failed to fetch products. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await _fetchProducts();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    String StartUrl =
        'C:/RupiyoSellerFirebaseTest/rupiyo_seller_Firebase_Test/Uploaded_images';
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: AppColor.BackgroundColor,
            )),
        title: const Text(
          'Fetch Product Details',
          style: TextStyle(color: AppColor.BackgroundColor),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: isRefreshing
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.mainColor,
                ),
              )
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return Column(
                    children: [
                      Column(
                        children: [
                          const Gap(30),
                          Container(
                            decoration:
                                const BoxDecoration(color: AppColor.mainColor),
                            width: 200,
                            height: 40,
                            child: Center(
                                child: Text(
                              product['id'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.BackgroundColor),
                            )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: AppColor.BackgroundColor,
                          elevation: 0,
                          margin: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '$StartUrl' +
                                                        product['image_path']),
                                                fit: BoxFit.contain)))),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    product['ProductName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product['Description'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                const Gap(2),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product['price'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product['category'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Created At: ${product['created_at']}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
