import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/TextInput.dart';

class PasswordRecovery extends StatefulWidget {
  static const id = "password_recovery";

  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  String code = '';
  bool isCurrentPasswordObsecure = true;
  bool isNewPasswordObsecure = true;
  late TextEditingController _currentPasswordController, _newPasswordController;
  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
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
                  Navigator.pop(context, LoginPage.id);
                },
                icon: Icon(Ionicons.arrow_back),
                color: Config.yallow,
                iconSize: 30,
              ).align(alignment: Alignment.topLeft).paddingOnly(
                    top: 30,
                  ),
              Spacer(),
              DefaultInput(
                controller: _currentPasswordController,
                label: "huidige wachtwoord",
                icon: Ionicons.lock_closed_outline,
                isObsecure: isCurrentPasswordObsecure,
                isPassword: true,
                showPassword: () {
                  setState(() {
                    isCurrentPasswordObsecure = !isCurrentPasswordObsecure;
                  });
                },
              ).paddingOnly(top: 50),
              DefaultInput(
                controller: _newPasswordController,
                label: "nieuwe wachtwoord",
                icon: Ionicons.lock_closed_outline,
                isObsecure: isNewPasswordObsecure,
                isPassword: true,
                showPassword: () {
                  setState(() {
                    isNewPasswordObsecure = !isNewPasswordObsecure;
                  });
                },
              ).paddingOnly(bottom: 50),
              Container(
                width: screenSize(context).width * .85,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Wachtwoord vergeten\n\b",
                      style: GoogleFonts.ubuntu(
                          fontSize: 26,
                          color: Config.yallow,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text:
                              "Ben je je wachtwoord vergeten? Vul je emailadres of gebruikersnaam in om je wachtwoord opnieuw in te stellen.",
                          style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: Config.yallow,
                              fontWeight: FontWeight.w400),
                        )
                      ]),
                ),
              ),
              Spacer(),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(25))),
                color: Config.yallow,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 250,
                  child: Center(
                    child: Text("Reset wachtwoord",
                        style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: Config.perpel,
                        )),
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
