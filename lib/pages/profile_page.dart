import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/pages/signup_page.dart';

import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  static const id = 'Profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool profile = true;
  bool messages = false;
  bool matches = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      color: Colors.white,
      child: CustomPaint(
        painter: LoginShapePainter(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CustomAppBar(
                username: "Leila",
                points: 34,
                niveau: 3,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            matches = false;
                            profile = true;
                            messages = false;
                          });
                        },
                        selected: profile,
                        title: Text(
                          "Profiel",
                          style: profile
                              ? GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Config.perpel)
                              : GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Config.perpel.withOpacity(0.7)),
                        ),
                        subtitle: Container(
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: profile ? Config.yallow : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            matches = false;
                            profile = false;
                            messages = true;
                          });
                        },
                        selected: messages,
                        title: Text(
                          "Vrienden",
                          style: messages
                              ? GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Config.perpel)
                              : GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Config.perpel.withOpacity(0.7)),
                        ),
                        subtitle: Container(
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                messages ? Config.yallow : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: ListTile(
                        selected: matches,
                        onTap: () {
                          setState(() {
                            matches = true;
                            profile = false;
                            messages = false;
                          });
                        },
                        title: Text(
                          "Wedstrijden",
                          style: matches
                              ? GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Config.perpel)
                              : GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Config.perpel.withOpacity(0.7)),
                        ),
                        subtitle: Container(
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: matches ? Config.yallow : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (profile)
                profileWidget()
              else if (messages)
                messagesWidget()
              else if (matches)
                matchesWidget()
            ],
          ),
        ),
      ),
    ));
  }

  messagesWidget() {
    return Column(
      children: [Text("Messages")],
    );
  }

  matchesWidget() {
    return Column(
      children: [
        // comming matches
        Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: screenSize(context).width * .92,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 5,
                        blurRadius: 70,
                        offset: Offset(0, 4),
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      "Comming matches",
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Config.yallow),
                    ).align(alignment: Alignment.topLeft),
                    Column(children: List.generate(3, (index) => mWidget()))
                  ],
                )),
            Text("matches",
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ))
                .align(alignment: Alignment.topRight)
                .paddingOnly(right: 20, top: 10)
          ],
        ),
        // pass matches
        Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: screenSize(context).width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 5,
                        blurRadius: 70,
                        offset: Offset(0, 4),
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      "Comming matches",
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Config.yallow),
                    ).align(alignment: Alignment.topLeft),
                    Column(children: List.generate(3, (index) => mWidget()))
                  ],
                )),
            Text("matches",
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ))
                .align(alignment: Alignment.topRight)
                .paddingOnly(right: 20, top: 10)
          ],
        ).paddingOnly(top: 20),
      ],
    );
  }

  mWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 70,
      width: screenSize(context).width * .92,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: Image.asset(
              "assets/images/football_1.png",
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 203,
                child: Text(
                  "Arsenalsanstsjs VS Arsonal",
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Config.perpel),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "09/12/2021  20:00",
                style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Config.perpel),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 60,
            width: 60,
            child: Image.asset(
              "assets/images/football_1.png",
            ),
          )
        ],
      ),
    );
  }

  profileWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: screenSize(context).width * .9,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 5,
                  blurRadius: 70,
                  offset: Offset(0, 4),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Profielgegevens",
                  style: GoogleFonts.ubuntu(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Config.yallow,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Naam",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.perpel,
                        )),
                    Spacer(),
                    Container(
                      width: 230,
                      child: TextFormField(
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.yallow,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Leeftijd",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.perpel,
                        )),
                    Spacer(),
                    Container(
                      width: 230,
                      child: TextFormField(
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.yallow,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Team",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.perpel,
                        )),
                    Spacer(),
                    Container(
                      width: 230,
                      child: TextFormField(
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.yallow,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Coach",
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.perpel,
                        )),
                    Spacer(),
                    Container(
                      width: 230,
                      child: TextFormField(
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.yallow,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.all(25),
          child: Row(
            children: [
              Icon(Ionicons.person_outline),
              SizedBox(
                width: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: "Mijn account\n",
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                    TextSpan(
                        text: "Mijn account",
                        style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ))
                  ])),
              Spacer(),
              Icon(Ionicons.arrow_forward)
            ],
          ),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          height: 2,
          thickness: 1.5,
          color: Colors.grey.withOpacity(0.8),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginPage.id);
          },
          child: Container(
            margin: EdgeInsets.all(25),
            child: Row(
              children: [
                Icon(
                  Ionicons.log_out_outline,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 20,
                ),
                RichText(
                    text: TextSpan(
                  text: "Log out",
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                )),
                Spacer(),
                Icon(
                  Ionicons.arrow_forward,
                  color: Colors.redAccent,
                )
              ],
            ),
          ),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          height: 2,
          thickness: 1.5,
          color: Colors.grey.withOpacity(0.8),
        )
      ],
    );
  }
}
