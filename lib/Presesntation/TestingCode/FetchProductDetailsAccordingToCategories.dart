import 'package:flutter/material.dart';

class CategoryPageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategoryContainer(
            categoryName: 'Fruits & Vegetables',
          ),
          CategoryContainer(
            categoryName: 'Sweets',
          ),
          CategoryContainer(
            categoryName: 'Masala',
          ),
        ],
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String categoryName;

  CategoryContainer({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to a new page and pass the category name
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(categoryName: categoryName),
            ),
          );
        },
        child: Text(
          categoryName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CategoryDetailsPage extends StatelessWidget {
  final String categoryName;

  CategoryDetailsPage({required this.categoryName});

  // Placeholder function to fetch data based on category from the database
  List<String> fetchDataFromDatabase() {
    // Replace this with actual database fetch logic
    if (categoryName == 'Fruits & Vegetables') {
      return ['Apple', 'Banana', 'Carrot', 'Tomato'];
    } else if (categoryName == 'Sweets') {
      return ['Gulab Jamun', 'Rasgulla', 'Jalebi'];
    } else if (categoryName == 'Masala') {
      return ['Cumin', 'Coriander', 'Turmeric', 'Chilli Powder'];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = fetchDataFromDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            // Add more details or actions as needed
          );
        },
      ),
    );
  }
}
