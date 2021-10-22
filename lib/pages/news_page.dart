import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/news_model.dart';
import 'package:soccer_app/pages/news_view_page.dart';
import 'package:soccer_app/pages/signup_page.dart';
import 'package:soccer_app/providers/news_provider.dart';

import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/home_app_bar_widget.dart';
import 'package:soccer_app/widgets/news_widget.dart';

class NewsPage extends StatefulWidget {
  static const id = 'news';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late WordpressContentProvider wordpressContentProvider;
  bool isCalled = false;
  Future<List<NewsModel>> newsData = Future.value(List.empty());

  @override
  void didChangeDependencies() {
    if (!isCalled) {
      wordpressContentProvider =
          Provider.of<WordpressContentProvider>(context, listen: false);
      load();
      setState(() {
        isCalled = true;
      });
    }

    super.didChangeDependencies();
  }

  load() async {
    newsData = wordpressContentProvider.loadNews();
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
                username: "Leila",
                avatar: Config.avatar,
                points: 34,
                niveau: 3,
              ),
              SizedBox(
                height: 80,
              ),
              newsContent(),
              // ListView.builder(
              //   primary: false,
              //   itemCount: wordpressContentProvider.news.length,
              //   itemExtent: 200,
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   itemBuilder: (BuildContext context, int index) {
              //     return InkWell(
              //       onTap: () {
              //         Navigator.pushNamed(context, NewsView.id,
              //             arguments: index);
              //       },
              //       child: NewsWidget(
              //           title: wordpressContentProvider.news[index].title,
              //           date: wordpressContentProvider.news[index].date,
              //           content: wordpressContentProvider.news[index].content,
              //           image_url:
              //               "https://thepressfree.com/wp-content/uploads/2021/09/3228313-66083528-2560-1440.jpg"),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget newsContent() {
    return FutureBuilder<List<NewsModel>>(
        future: newsData,
        builder: (context, snapchot) {
          if (snapchot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapchot.hasData) {
            return Center(
              child: Text('There is no new at the moment'),
            );
          }
          return ListView.builder(
            primary: false,
            itemCount: snapchot.data!.length,
            itemExtent: 200,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              print("new s ${snapchot.data![index].content?.length}");
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, NewsView.id,
                      arguments: snapchot.data![index]);
                },
                child: NewsWidget(
                    title: snapchot.data![index].title,
                    date: snapchot.data![index].date,
                    content: snapchot.data![index].content.toString(),
                    image_url:
                        "https://thepressfree.com/wp-content/uploads/2021/09/3228313-66083528-2560-1440.jpg"),
              );
            },
          );
        });
  }
}
