import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/onBoarding.dart';
import 'package:soccer_app/pages/password_recovery_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ActivationPage extends StatefulWidget {
  static const id = "activation";

  @override
  _ActivationPageState createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  String code = '';
  bool _isResendAgain = false;
  // ignore: unused_field
  Timer? _timer;
  int _start = 60;
  String routeFrom = "";

  @override
  void initState() {
    WidgetsBinding.instance?.scheduleFrameCallback((timeStamp) {
      routeFrom = ModalRoute.of(context)?.settings.arguments as String;
    });

    super.initState();
  }

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(color: Config.perpel),
        child: CustomPaint(
          painter: LoginShapePainter(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Ionicons.arrow_back),
                color: Config.yallow,
                iconSize: 30,
              )
                  .align(alignment: Alignment.topLeft)
                  .paddingOnly(top: 10, left: 10),
              SizedBox(
                height: 150,
              ),
              OtpTextField(
                textStyle: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w600, color: Config.perpel),
                numberOfFields: 4,
                borderColor: Config.yallow,
                enabledBorderColor: Config.yallow,
                focusedBorderColor: Config.yallow,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                filled: true,
                fillColor: Config.yallow,
                onSubmit: (String verificationCode) {
                  print(verificationCode);
                }, // end onSubmit
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code niet ontvangen?",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade300),
                  ),
                  TextButton(
                      onPressed: () {
                        if (_isResendAgain) return;
                        resend();
                      },
                      child: Text(
                        _isResendAgain
                            ? "Probeer het opnieuw in " + _start.toString()
                            : "Opnieuw verzenden",
                        style: TextStyle(color: Config.yallow),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 50),
                width: screenSize(context).width * .85,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Verificatie code\n\b",
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
              ),
              MaterialButton(
                onPressed: () {
                  if (routeFrom == "signup") {
                    Navigator.pushReplacementNamed(context, OnBoarding.id);
                  } else {
                    Navigator.pushReplacementNamed(
                        context, PasswordRecovery.id);
                  }
                },
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(25))),
                color: Config.yallow,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  child: Row(
                    children: [
                      Text("Controleren",
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            color: Config.perpel,
                          )),
                      Spacer(),
                      Icon(
                        Ionicons.checkmark_circle_outline,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
