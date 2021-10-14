import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/forgert_password_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/TextInput.dart';

class LoginPage extends StatefulWidget {
  static const id = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObsecure = true;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPaint(
          foregroundPainter: ShapePainter(),
          child: Container(
              height: screenSize(context).height,
              width: screenSize(context).width,
              color: Config.perpel,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Inloggen",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 48, color: Colors.white))
                          .paddingOnly(top: 100, left: 20, bottom: 30),
                    ),
                    DefaultInput(
                      label: "Gebruikersnaam of email",
                      icon: Ionicons.person_outline,
                    ),
                    DefaultInput(
                      label: "Wachtwoord",
                      icon: Ionicons.lock_closed_outline,
                      isObsecure: isObsecure,
                      isPassword: true,
                      showPassword: () {
                        setState(() {
                          isObsecure = !isObsecure;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PasswordRecoveryPage.id);
                        },
                        child: Text("Wachtwoord vergent?",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline))
                            .paddingOnly(top: 10, right: 20, bottom: 50),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        formKey.currentState?.validate();
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25))),
                      color: Config.yallow,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: screenSize(context).width * .80,
                        child: Row(
                          children: [
                            Text("Inloggen",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  color: Config.perpel,
                                )),
                            Spacer(),
                            Icon(
                              Ionicons.log_in_outline,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: screenSize(context).width * .45,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Config.blue,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.logo_facebook,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  Text("Inloggen met facebook",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 13,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: screenSize(context).width * .42,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Config.red,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.logo_google,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  Text("Inloggen met google",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 13,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Heb je geen account? ",
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        GestureDetector(
                          child: Text("Inscherjiven",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline)),
                          onTap: () {
                            Navigator.pushNamed(context, SignupPage.id);
                          },
                        )
                      ],
                    ),
                    Spacer(),
                    Text("V1.0",
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          color: Colors.grey,
                        )).paddingOnly(bottom: 10),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintc = Paint()
      ..color = Config.yallow
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var pathc = Path();
    pathc.addOval(Rect.fromCircle(
      center: Offset(size.width * .96, size.height * .08),
      radius: 170,
    ));
    canvas.drawPath(pathc, paintc);
    var paint = Paint()
      ..color = Config.yallow
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width * .9, size.height * 1.15),
      radius: 160,
    ));
    canvas.drawPath(path, paint);
    var paint2 = Paint()
      ..color = Config.yallow
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path2 = Path();
    path2.addOval(Rect.fromCircle(
      center: Offset(size.width * .9, size.height * 1.15),
      radius: 130,
    ));
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
