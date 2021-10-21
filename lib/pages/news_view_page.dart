import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/providers/news_provider.dart';
import 'package:soccer_app/services/services.dart';

class NewsView extends StatefulWidget {
  static const id = 'news_view';

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late WordpressContentProvider newsProvider;
  bool isCalled = false;
  late int index;

  @override
  void didChangeDependencies() {
    if (!isCalled) {
      newsProvider =
          Provider.of<WordpressContentProvider>(context, listen: false);
      index = ModalRoute.of(context)!.settings.arguments as int;
      newsProvider.loadNews();
      setState(() {
        isCalled = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          elevation: 0,
          snap: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.grey.shade50,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                "https://drop.ndtv.com/albums/SPORTS/livleedspl/1.jpg",
                fit: BoxFit.cover,
              )),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(85),
              child: Transform.translate(
                offset: Offset(0, 1),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            height: MediaQuery.of(context).size.height * .7,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${newsProvider.news[index].title}",
                  style: GoogleFonts.ubuntu(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Config.perpel),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${newsProvider.news[index].date}",
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${newsProvider.news[index].content}",
                  style: GoogleFonts.ubuntu(fontSize: 18, color: Colors.black),
                ),
              ],
            )),
          )
        ])),
      ]),
    );
  }
}
