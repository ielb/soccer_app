import 'package:flutter/material.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  static const id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  Widget currentPage(int index) {
    switch (index) {
      case 0:
        return HomePage();

      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      color: Colors.white,
      child: CustomPaint(
        painter: LoginShapePainter(),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CustomAppBar(
              username: "Leila",
              points: 34,
              niveau: 3,
            )
          ],
        ),
      ),
    ));
  }
}
