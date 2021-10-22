import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/models/news_model.dart';

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
  late NewsModel news;

  @override
  void didChangeDependencies() {
    if (!isCalled) {
      newsProvider =
          Provider.of<WordpressContentProvider>(context, listen: false);
      news = ModalRoute.of(context)!.settings.arguments as NewsModel;
      setState(() {
        isCalled = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String htmlData = news.content ?? '';
    print(news.content?.length);
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
                  "${news.title}",
                  style: GoogleFonts.ubuntu(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Config.perpel),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${news.date}",
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Html(
                  data: htmlData,
                  style: {
                    "img": Style(margin: EdgeInsets.all(5)),
                    "table": Style(
                      width: screenSize(context).width,
                      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    ),
                    "tr": Style(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    "th": Style(
                      padding: EdgeInsets.all(6),
                      backgroundColor: Colors.grey,
                    ),
                    "td": Style(
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.topLeft,
                    ),
                    'h5':
                        Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                  },
                  customRender: {
                    "table": (context, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: (context.tree as TableLayoutElement)
                            .toWidget(context),
                      );
                    },
                  },
                )
              ],
            )),
          )
        ])),
      ]),
    );
  }
}
