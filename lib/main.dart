import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input_test.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rupiyo_seller/Dot.dart';
import 'package:rupiyo_seller/Form.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/BankDetails.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/BottomBar.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Dashboard.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Drawer/DrawerList.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Email%20Verfication.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Profile.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/SalesSummary.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/SelectContainers.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/Slivar.dart';
import 'package:rupiyo_seller/Presesntation/HomePage/StoreDetails.dart';
import 'package:rupiyo_seller/Presesntation/Map/CurrentLocation.dart';
import 'package:rupiyo_seller/Presesntation/Map/Map.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/CardAnimation.dart';

import 'package:rupiyo_seller/Presesntation/Onboarding/ContactDetails.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/ModifiedOnBoard.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/SellerDetails.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/Welcome.dart';

import 'package:rupiyo_seller/Presesntation/Onboarding/mainPage.dart';
import 'package:rupiyo_seller/Presesntation/Onboarding/onBoarding.dart';
import 'package:rupiyo_seller/Presesntation/Orders/Orders.dart';
import 'package:rupiyo_seller/Presesntation/SplashScreen/SplashScreen.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/CreateEmail.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/EmailFieldTesting.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Fast2SMS/Fast2smsPhone.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/FetchProductDetails.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/ImageTesting.dart/ImageUpload.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/ImageUpload.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OrdersPage.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/OtpFieldTesting.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/PhoneFirebase.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/PhoneTesting.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/ProductListing.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SecondDashboard.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SelectSubscription.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/SellerDetailsForm.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/StoreDetails.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/TrialDashboard.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/Login.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/StoreUserInformation.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/Users/UserDashboard.dart';
import 'package:rupiyo_seller/Presesntation/TestingCode/validationTest.dart';
import 'package:rupiyo_seller/Presesntation/TestingData.dart';
import 'package:rupiyo_seller/Presesntation/Widgets/Fetched_Data.dart';
import 'package:rupiyo_seller/Presesntation/Widgets/NoData.dart';
import 'package:rupiyo_seller/Presesntation/Widgets/OTP.dart';
import 'package:rupiyo_seller/Providers/SellerDataProvider.dart';
import 'package:rupiyo_seller/Sellers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // //MapmyIndiaMapController.initialize();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // var initializationSettingsAndroid =
  //     const AndroidInitializationSettings('@mipmap/ic_launcher');
  // // var initializationSettingsIOS = IOSInitializationSettings();
  // var initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  // );

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Firebase.initializeApp(
      //   options: const FirebaseOptions(
      //   apiKey: "XXX",
      //   appId: "XXX",
      //   messagingSenderId: "XXX",
      //   projectId: "XXX",
      // ),
      );

  //Request Notification permission
  //await Permission.notification.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
            headlineMedium: TextStyle(color: AppColor.BackgroundColor),
            labelLarge: TextStyle(color: AppColor.BackgroundColor),
            titleLarge: TextStyle(color: AppColor.BackgroundColor),
            labelMedium: TextStyle(color: AppColor.BackgroundColor),
          ),
          dialogBackgroundColor: AppColor.BackgroundColor,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
          useMaterial3: true),
      home: const Fast2smsOtp(),
    );
  }
}
// Background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// print("Handling a background message: ${message.messageId}");
// }

