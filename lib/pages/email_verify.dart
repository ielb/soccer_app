import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/home_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';

class ActivationPage extends StatefulWidget {
  static const id = "activation";

  @override
  _ActivationPageState createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  String routeFrom = "";
  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance?.scheduleFrameCallback((timeStamp) {
      routeFrom = ModalRoute.of(context)?.settings.arguments as String;
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(color: Config.perpel),
        child: CustomPaint(
          painter: LoginShapePainter(),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Ionicons.arrow_back),
                color: Config.yallow,
                iconSize: 30,
              )
                  .align(alignment: Alignment.topLeft)
                  .paddingOnly(top: 50, left: 10),
              Container(
                child: Image.asset(
                  Config.thumbsUp,
                  height: 350,
                ),
              ),
              Container(
                width: screenSize(context).width * .85,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Verificatie Link\n\b",
                      style: GoogleFonts.ubuntu(
                          fontSize: 26,
                          color: Config.yallow,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text:
                              "Je ontvangt een verificatie code in je mail. Vul deze hierboven in om je account te bevestigen.",
                          style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: Config.yallow,
                              fontWeight: FontWeight.w400),
                        )
                      ]),
                ),
              ).paddingOnly(bottom: 40),
            ],
          ),
        ),
      ),
    );
  }
}
