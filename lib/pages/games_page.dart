import 'package:flutter/material.dart';
import 'package:soccer_app/pages/signup_page.dart';

import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';

class GamesPage extends StatefulWidget {
  static const id = 'games';

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List<String> images = [
    Config.math_game,
    Config.memory_game,
    Config.quiz_game,
    Config.asign_game,
  ];
  List<String> titles = ["Rekenen", "Memory", "Quiz", "Opdrachtjes"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize(context).width,
          height: screenSize(context).height,
          color: Colors.white,
          child: CustomPaint(
            painter: LoginShapePainter(),
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              CustomAppBar(
                username: "Leila",
                avatar: Config.avatar,
                points: 34,
                niveau: 3,
              ),
              Spacer(),
              GridView(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 160),
                  children: List.generate(
                    4,
                    (i) => InkWell(
                      onTap: () {
                        print("test");
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 170,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Config.perpel,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Image.asset(
                              images[i],
                              height: 95,
                            ),
                            Spacer(),
                            Text(
                              titles[i],
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.ubuntu(
                                  fontSize: 22,
                                  color: Config.yallow,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  )).paddingOnly(right: 20, left: 20),
              Spacer()
            ]),
          ),
        ),
      ),
    );
  }
}
