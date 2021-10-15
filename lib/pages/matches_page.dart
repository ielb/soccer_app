import 'package:flutter/material.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';

class MatchesPage extends StatelessWidget {
  static const id = 'MatchesPage';

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
