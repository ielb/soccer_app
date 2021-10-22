import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/user_model.dart';
import 'package:soccer_app/pages/login_page.dart';
import 'package:soccer_app/pages/search_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/providers/chat_provider.dart';
import 'package:soccer_app/providers/user_provider.dart';
import 'package:soccer_app/widgets/search.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

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
  bool called = false;
  late TextEditingController _name, _age, _team, _coach, _search;

  late UserProvider userProvider;
  late ChatProvider chatProvider;

  @override
  void didChangeDependencies() {
    if (!called) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      chatProvider = Provider.of<ChatProvider>(context, listen: false);
      _name = TextEditingController(text: userProvider.user?.name ?? '');
      _age = TextEditingController(text: "${userProvider.user?.age ?? ''}");
      _team = TextEditingController(text: userProvider.user?.team ?? '');
      _coach = TextEditingController(text: userProvider.user?.coach ?? '');
      _search = TextEditingController();

      setState(() {
        called = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    update();
    super.dispose();
  }

  submit() {
    update();
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "Good job, your information has been updated",
      ),
    );
  }

  void update() async {
    UserModel user = UserModel(
        uid: userProvider.user!.uid,
        name: _name.text,
        age: int.tryParse(_age.text),
        email: userProvider.user!.email,
        avatar: userProvider.user!.avatar,
        coach: _coach.text,
        team: _team.text);
    await userProvider.editProfile(userModel: user);
  }

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
                username: userProvider.user?.name,
                avatar: userProvider.user?.avatar ?? Config.avatar,
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
                height: 10,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchInput(
          _search,
          "search",
          screenSize(context).width * .9,
          Ionicons.search_outline,
          isEnabled: false,
          onTap: () {
            Navigator.pushNamed(context, SearchPage.id);
          },
        ).paddingOnly(left: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 20),
              height: 81,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) =>
                    messageTile().paddingOnly(left: 20),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Berichten",
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text(
                  //number
                  "Je hebt 2 nieuwe berichten",
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                )
              ],
            ).paddingOnly(left: 25, top: 20),
            Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, i) => rowMessageTile(),
              ),
            )
          ],
        )
      ],
    );
  }

  addFriend() {}

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
                      "yesterday matches",
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Config.yallow),
                    ).align(alignment: Alignment.topLeft),
                    Column(children: List.generate(3, (index) => yWidget()))
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text(
                  "Arsenalsanx VS Arsonal",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Config.perpel),
                ),
              ),
              SizedBox(
                height: 10,
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

  yWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 70,
      width: screenSize(context).width * .92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text(
                  "Arsenalsanx VS Arsonal",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Config.perpel),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "0 : 0",
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
                        controller: _name,
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
                        controller: _age,
                        keyboardType: TextInputType.number,
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
                        controller: _team,
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
                        controller: _coach,
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Config.yallow,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                        onFieldSubmitted: (text) {
                          submit();
                        },
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
        InkWell(
          onTap: () {},
          child: Container(
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

  ///  MESSAGES WIDGETS''
  Widget messageTile() => Container(
        child: Column(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1554151228-14d9def656e4",
                    errorWidget: (context, _, err) {
                      return Image.asset(Config.error_image);
                    },
                    progressIndicatorBuilder: (context, _, dow) =>
                        CircularProgressIndicator(
                      value: dow.progress,
                      color: Config.yallow,
                    ).center(),
                    fit: BoxFit.cover,
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 45,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.circular(20)),
                    )),
              ],
            ),
            Text(
              "Jane",
              style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ).paddingOnly(top: 5)
          ],
        ),
      );

  Widget rowMessageTile() => Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1554151228-14d9def656e4",
                    errorWidget: (context, _, err) {
                      return Image.asset(Config.error_image);
                    },
                    progressIndicatorBuilder: (context, _, dow) =>
                        CircularProgressIndicator(
                      value: dow.progress,
                      color: Config.yallow,
                    ).center(),
                    fit: BoxFit.cover,
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 45,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.greenAccent[400],
                          borderRadius: BorderRadius.circular(20)),
                    )),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "jane",
                    style: GoogleFonts.ubuntu(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      "I'will meet you there to night",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.ubuntu(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  "now",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Config.yallow,
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          ],
        ),
      );
}
