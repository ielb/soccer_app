import 'package:flutter/material.dart';
import 'package:soccer_app/pages/news_view_page.dart';
import 'package:soccer_app/pages/signup_page.dart';

import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';
import 'package:soccer_app/widgets/news_widget.dart';

class NewsPage extends StatefulWidget {
  static const id = 'news';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
                height: 80,
              ),
              ListView.builder(
                primary: false,
                itemCount: 5,
                itemExtent: 200,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, NewsView.id);
                    },
                    child: NewsWidget(
                        title: "Lorem Ipsum",
                        date: "17/10/2021",
                        content:
                            "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker.",
                        image_url:
                            "https://thepressfree.com/wp-content/uploads/2021/09/3228313-66083528-2560-1440.jpg"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
