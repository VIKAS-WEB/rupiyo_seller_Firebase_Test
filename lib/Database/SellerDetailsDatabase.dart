// import 'package:mysql1/mysql1.dart';
// import 'package:rupiyo_seller/Models/SellerDetails.dart';

// Future<void> insertDataToMySql(SellerDetails data) async {
//   final MySqlConnection connection = await MySqlConnection.connect(
//       ConnectionSettings(
//           host: '192.168.1.86',
//           //port: ,
//           user: 'root',
//           db: 'rupiyo_seller',
//           password: ''));

//   try {
//     await connection.query(
//       'INSERT INTO shopdetails (ShopName) VALUES (?)',
//       [data.ShopName],
//     );

//     print('Data inserted successfully');
//   } catch (e) {
//     print('Error inserting data: $e');
//   } finally {
//     await connection.close();
//   }
// }
