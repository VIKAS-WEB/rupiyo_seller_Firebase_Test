import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupiyo_seller/Presesntation/Colors/Colors.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: AppColor.BackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: AppColor.textColor,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Sales Summary',
            style: TextStyle(
                fontSize: 19,
                color: AppColor.textColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        actions: const [
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
            CupertinoIcons.search,
            color: AppColor.textColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                      Expanded(
                      flex: 2,
                      child: Container(
                      height: 120,
                      width: 190,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFF00afaf),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            size: 40,
                            color: AppColor.BackgroundColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '24',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.BackgroundColor,
                                    fontSize: 30),
                              ),
                              Text(
                                'completed',
                                style: TextStyle(
                                    color: AppColor.BackgroundColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFF9085fd),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled,
                            size: 40,
                            color: AppColor.BackgroundColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '32',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.BackgroundColor,
                                    fontSize: 30),
                              ),
                              Text('Shipped',
                                  style: TextStyle(
                                      color: AppColor.BackgroundColor,
                                      fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFF33c8fe),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.xmark_circle,
                            size: 40,
                            color: AppColor.BackgroundColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '12',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.BackgroundColor,
                                    fontSize: 30),
                              ),
                              Text('Canceled',
                                  style: TextStyle(
                                      color: AppColor.BackgroundColor,
                                      fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFFff3378),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.graph_square,
                            size: 40,
                            color: AppColor.BackgroundColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '09',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.BackgroundColor,
                                    fontSize: 30),
                              ),
                              Text('Processing',
                                  style: TextStyle(
                                      color: AppColor.BackgroundColor,
                                      fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Orders',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Card(
                    elevation: 2,
                    shadowColor: AppColor.textColor,
                    child: Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(
                              image: AssetImage('Assets/Images/bank.png'),
                              width: 40,
                              height: 60,
                            ),
                            const Text('Cocount'),
                            Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade200,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text('Processings',
                                      style: TextStyle(
                                          color: AppColor.BackgroundColor))),
                            ),
                            const Icon(CupertinoIcons.eye_solid),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: AppColor.textColor,
                    child: Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(
                              image: AssetImage('Assets/Images/bank.png'),
                              width: 40,
                              height: 60,
                            ),
                            const Text('Vegitables'),
                            Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text('Canceled',
                                      style: TextStyle(
                                          color: AppColor.BackgroundColor))),
                            ),
                            const Icon(CupertinoIcons.eye_solid),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: AppColor.textColor,
                    child: Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(
                              image: AssetImage('Assets/Images/bank.png'),
                              width: 40,
                              height: 60,
                            ),
                            const Text('Grapes'),
                            Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent.shade200,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text('Shipped',
                                      style: TextStyle(
                                          color: AppColor.BackgroundColor))),
                            ),
                            const Icon(CupertinoIcons.eye_solid),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: AppColor.textColor,
                    child: Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(
                              image: AssetImage('Assets/Images/bank.png'),
                              width: 40,
                              height: 60,
                            ),
                            const Text('Cosmetics'),
                            Container(
                              width: 110,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text('Done',
                                      style: TextStyle(
                                          color: AppColor.BackgroundColor))),
                            ),
                            const Icon(CupertinoIcons.eye_solid),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
