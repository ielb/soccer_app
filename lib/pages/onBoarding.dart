import 'package:flutter/material.dart';
import 'package:soccer_app/models/content_model_bording.dart';
import 'package:soccer_app/pages/PagesControlle.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/services/services.dart';

class OnBoarding extends StatefulWidget {
  static const id = "onBoarding";
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          painter: LoginShapePainter(),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 280,
                        ),
                        Text(
                          contents[i].title,
                          style: GoogleFonts.ubuntu(
                              fontSize: 35,
                              color: Config.perpel,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 20),
                        Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            color: Config.perpel,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.all(40),
                width: 200,
                child: MaterialButton(
                  child: Text(
                    currentIndex == contents.length - 1 ? "Continue" : "Next",
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushNamed(context, PageControlle.id);
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    }
                  },
                  minWidth: 200,
                  color: Config.yallow,
                  textColor: Config.perpel,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Config.yallow,
      ),
    );
  }
}
