import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  //height: 580,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.asset('Assets/Images/NoData.jpg'),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Orders Yet',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight:  FontWeight.w600,
                      fontFamily: 'Assets/Fonts/Poppins-Bold.ttf'),
                ),
              ],
            ),
            const Text(
              'Look Like  No One Have ordered Yet',
              style: TextStyle(
                  fontSize: 14, fontFamily: 'Assets/Fonts/Poppins-Regular.ttf'),
            ),
          ],
        
      ),
    );
  }
}
