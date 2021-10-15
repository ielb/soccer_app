import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_app/pages/games_page.dart';
import 'package:soccer_app/pages/home_page.dart';
import 'package:soccer_app/pages/matches_page.dart';
import 'package:soccer_app/pages/news_page.dart';
import 'package:soccer_app/pages/profile_page.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/navigation_bar_widget.dart';

class PageControlle extends StatefulWidget {
  static const id = 'controlle';

  @override
  _PageControlleState createState() => _PageControlleState();
}

class _PageControlleState extends State<PageControlle> {
  int currentIndex = 0;
  Widget currentPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return ProfilePage();
      case 4:
        return GamesPage();
      case 2:
        return NewsPage();
      case 3:
        return MatchesPage();

      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: currentPage(currentIndex),
        bottomNavigationBar: CustomBottomBar(
          curve: Curves.easeOutQuad,
          currentIndex: currentIndex,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          items: [
            /// Home
            CustomBottomBarItem(
              icon: Icon(Ionicons.home_outline),
              title: Text(
                "Home",
              ),
              selectedColor: Config.yallow,
            ),

            /// Likes

            CustomBottomBarItem(
              icon: Icon(Ionicons.person_outline),
              title: Text("Profiel"),
              selectedColor: Config.yallow,
            ),
            CustomBottomBarItem(
              icon: Icon(Ionicons.newspaper_outline),
              title: Text("Nieuws"),
              selectedColor: Config.yallow,
            ),
            CustomBottomBarItem(
              icon: Image.asset(
                Config.soccer_icon,
                height: 26,
                color: currentIndex == 3 ? Config.perpel : Colors.black,
              ),
              title: Text("Wedstrijden"),
              selectedColor: Config.yallow,
            ),

            /// Search
            CustomBottomBarItem(
              icon: Icon(Ionicons.football_outline),
              title: Text("Games"),
              selectedColor: Config.yallow,
            ),

            /// Profile
          ],
        ),
      ),
    );
  }
}
