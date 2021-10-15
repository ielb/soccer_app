import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';

class NotificationPage extends StatefulWidget {
  static const id = "notification";

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            color: Colors.white,
            child: CustomPaint(
                painter: LoginShapePainter(),
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Ionicons.arrow_back),
                        color: Config.yallow,
                        iconSize: 30,
                      )
                          .align(alignment: Alignment.topLeft)
                          .paddingOnly(top: 60, left: 10),
                    ])))));
  }
}
