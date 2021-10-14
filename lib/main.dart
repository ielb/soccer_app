import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/pages/forgert_password_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KnorriePlay',
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      onGenerateRoute: routes,
    );
  }
}

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case Splash.id:
      return CupertinoPageRoute(builder: (_) => Splash(), settings: settings);
    case LoginPage.id:
      return CupertinoPageRoute(
          builder: (_) => LoginPage(), settings: settings);
    case SignupPage.id:
      return CupertinoPageRoute(
          builder: (_) => SignupPage(), settings: settings);
    case PasswordRecoveryPage.id:
      return CupertinoPageRoute(
          builder: (_) => PasswordRecoveryPage(), settings: settings);

    default:
      return CupertinoPageRoute(builder: (_) => Splash(), settings: settings);
  }
}
