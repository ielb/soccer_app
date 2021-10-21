import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/pages/PagesControlle.dart';
import 'package:soccer_app/pages/email_verify.dart';
import 'package:soccer_app/pages/forgert_password_page.dart';
import 'package:soccer_app/pages/games_page.dart';
import 'package:soccer_app/pages/home_page.dart';
import 'package:soccer_app/pages/news_page.dart';
import 'package:soccer_app/pages/news_view_page.dart';
import 'package:soccer_app/pages/notification_page.dart';
import 'package:soccer_app/pages/onBoarding.dart';
import 'package:soccer_app/pages/password_recovery_page.dart';
import 'package:soccer_app/pages/profile_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/pages/splash.dart';
import 'package:soccer_app/providers/auth_provider.dart';
import 'package:soccer_app/providers/news_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => WordpressContentProvider()),
  ], child: MyApp()));
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
    case ActivationPage.id:
      return CupertinoPageRoute(
          builder: (_) => ActivationPage(), settings: settings);
    case OnBoarding.id:
      return CupertinoPageRoute(
          builder: (_) => OnBoarding(), settings: settings);
    case PasswordRecovery.id:
      return CupertinoPageRoute(
          builder: (_) => PasswordRecovery(), settings: settings);
    case HomePage.id:
      return CupertinoPageRoute(builder: (_) => HomePage(), settings: settings);
    case PageControlle.id:
      return CupertinoPageRoute(
          builder: (_) => PageControlle(), settings: settings);
    case ProfilePage.id:
      return CupertinoPageRoute(
          builder: (_) => ProfilePage(), settings: settings);
    case GamesPage.id:
      return CupertinoPageRoute(
          builder: (_) => GamesPage(), settings: settings);
    case NewsPage.id:
      return CupertinoPageRoute(builder: (_) => NewsPage(), settings: settings);
    case NewsView.id:
      return CupertinoPageRoute(builder: (_) => NewsView(), settings: settings);
    case NotificationPage.id:
      return CupertinoPageRoute(
          builder: (_) => NotificationPage(), settings: settings);

    default:
      return CupertinoPageRoute(builder: (_) => Splash(), settings: settings);
  }
}
