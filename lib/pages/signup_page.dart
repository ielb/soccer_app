import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/pages/email_verify.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/providers/auth_provider.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/TextInput.dart';

class SignupPage extends StatefulWidget {
  static const id = "Signup";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isObsecure = true;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  late TextEditingController _emailController,
      _userNameController,
      _passwordController;
  late AuthProvider authProvider;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  register() async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate && isChecked) {
      bool result = await authProvider.register(
          email: _emailController.text,
          userName: _userNameController.text,
          password: _passwordController.text);
      if (result)
        Navigator.pushNamed(context, ActivationPage.id, arguments: "signup");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to our terms of condition'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Container(
          height: screenSize(context).height + 11,
          width: screenSize(context).width,
          color: Config.perpel,
          child: CustomPaint(
              painter: LoginShapePainter(),
              child: Form(
                key: formKey,
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Inschrijven",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 40, color: Colors.white))
                          .paddingOnly(left: 20, bottom: 10),
                    ),
                    Spacer(),
                    DefaultInput(
                      controller: _emailController,
                      label: "Email",
                      icon: Ionicons.mail_outline,
                    ),
                    DefaultInput(
                      controller: _userNameController,
                      label: "Gebruikersnaam",
                      isText: true,
                      icon: Ionicons.person_outline,
                    ),
                    DefaultInput(
                      controller: _passwordController,
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
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isChecked
                                  ? Ionicons.checkbox_outline
                                  : Ionicons.square_outline,
                              color: !isChecked
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Door een account aan te maken, gaat u akkoord \nmet onze Algemene voorwaarden",
                              style: GoogleFonts.ubuntu(
                                fontSize: 14,
                                color: !isChecked
                                    ? Colors.redAccent
                                    : Colors.white,
                              ),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () {
                        register();
                      },
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25))),
                      color: Config.yallow,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: screenSize(context).width * .70,
                        child: Row(
                          children: [
                            Text("Inschrijven",
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("heb al een account? ",
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        GestureDetector(
                          child: Text("Inloggen",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline)),
                          onTap: () {
                            Navigator.pop(context, LoginPage.id);
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

class LoginShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintc = Paint()
      ..color = Config.yallow
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var pathc = Path();
    pathc.addOval(Rect.fromCircle(
      center: Offset(size.width * .96, size.height * .05),
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
