import 'package:flutter/material.dart';

import 'Bodies/home_page_body.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blur_background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: HomePageBody(),
        ),
      )
    );
  }

}