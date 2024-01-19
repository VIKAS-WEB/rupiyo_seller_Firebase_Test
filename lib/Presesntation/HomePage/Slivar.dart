
import 'package:flutter/material.dart';

class SliverTest extends StatelessWidget {
  const SliverTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [],
                collapseMode: CollapseMode.pin,
                title: Text('SliverAppBar Example'),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/Images/bg.jpeg'), // Replace with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 50,
              ),
            ),
          ],
        ),
    );
  }
}