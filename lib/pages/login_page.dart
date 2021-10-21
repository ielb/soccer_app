import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/pages/PagesControlle.dart';
import 'package:soccer_app/pages/forgert_password_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/providers/auth_provider.dart';
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
  late TextEditingController _emailController, _passwordController;
  late AuthProvider authProvider;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
    });

    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  login() async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      var result = await authProvider.login(
          email: _emailController.text, password: _passwordController.text);
      if (result) {
        Navigator.pushReplacementNamed(context, PageControlle.id);
      }
    }
  }

  googleAuth() async {
    var result = await authProvider.signInWithGoogle();
    if (result) {
      Navigator.pushReplacementNamed(context, PageControlle.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong please try again'),
        ),
      );
    }
  }

  facebookAuth() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenSize(context).height + 45,
            width: screenSize(context).width,
            color: Config.perpel,
            child: CustomPaint(
                painter: LoginShapePainter(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Inloggen",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 48, color: Colors.white))
                            .paddingOnly(top: 40, left: 20, bottom: 20),
                      ),
                      Spacer(),
                      DefaultInput(
                        controller: _emailController,
                        label: "Gebruikersnaam of email",
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
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PasswordRecoveryPage.id);
                          },
                          child: Text("Wachtwoord vergeten?",
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline))
                              .paddingOnly(top: 10, right: 20),
                        ),
                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {
                          login();
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
                              onTap: () {
                                facebookAuth();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 180,
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
                                    Text("Inloggen met Facebook",
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
                              onTap: () {
                                googleAuth();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 170,
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
                                    Text("Inloggen met Google",
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
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Heb je geen account? ",
                              style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                          GestureDetector(
                            child: Text("Inschrijven",
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
      ),
    );
  }
}
