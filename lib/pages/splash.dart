import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/pages/PagesControlle.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/preferences/prefs.dart';
import 'package:soccer_app/providers/user_provider.dart';

import 'package:soccer_app/services/services.dart';

class Splash extends StatefulWidget {
  static const id = "splash";

  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer _timer;
  late UserProvider userProvider;
  @override
  void initState() {
    _timer = Timer(Duration(seconds: 5), () {
      checkAuth();
    });
    super.initState();
  }

  void checkAuth() async {
    String? uid = await Prefs.instance.getUid();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    if (uid != null) {
      userProvider.getAuthUser(uid);
      Navigator.pushReplacementNamed(context, PageControlle.id);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.id);
    }
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(Config.handsUpImage), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: const BoxDecoration(color: Config.yallow),
        child: CustomPaint(
          painter: ShapePainter(),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Icon(
                Ionicons.football,
                size: 100,
              ),
              Container(
                child: Image.asset(
                  "assets/images/Blije_Knorrie.png",
                  height: 300,
                ),
              ),
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'KnorriePlay ®',
                    style: TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 0,
                      fontSize: 38,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4.5
                        ..color = Colors.white,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'KnorriePlay ®',
                    style: TextStyle(
                      fontSize: 38,
                      letterSpacing: 2,
                      color: Config.perpel,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'V 1.0',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: Colors.grey,
                ),
              ).paddingOnly(bottom: 10),
            ],
          ),
        ),
      ),
    ));
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintc = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var pathc = Path();
    pathc.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height * .812),
      radius: 80,
    ));
    canvas.drawPath(pathc, paintc);
    var paintn = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var pathn = Path();
    pathn.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height * .809),
      radius: 7,
    ));
    canvas.drawPath(pathn, paintn);
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.moveTo(0, size.height / 1.4);
    path.lineTo(size.width, size.height * .9);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
