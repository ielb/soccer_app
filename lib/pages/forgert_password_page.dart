import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/email_verify.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/TextInput.dart';

class PasswordRecoveryPage extends StatefulWidget {
  static const id = "recovery";

  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String code = '';
  late TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Ionicons.arrow_back),
                color: Config.yallow,
                iconSize: 30,
              )
                  .align(alignment: Alignment.topLeft)
                  .paddingOnly(top: 40, left: 10),
              Spacer(),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Wachtwoord\nResetten",
                        style: GoogleFonts.ubuntu(
                            fontSize: 38, color: Config.yallow))
                    .paddingOnly(
                  left: 20,
                ),
              ),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "voer uw e-mailadres in om uw wachtwoord opnieuw in te stellen",
                    style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: Config.yallow,
                        fontWeight: FontWeight.w400),
                  )),
              Spacer(),
              DefaultInput(
                controller: _emailController,
                label: "Gebruikersnaam of email",
                icon: Ionicons.person_outline,
              ),
              Spacer(),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, ActivationPage.id,
                      arguments: "password");
                },
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(25))),
                color: Config.yallow,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: screenSize(context).width * .55,
                  child: Row(
                    children: [
                      Text("Code verzenden",
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
              ).paddingOnly(bottom: 50),
            ],
          ),
        ),
      )),
    );
  }
}
