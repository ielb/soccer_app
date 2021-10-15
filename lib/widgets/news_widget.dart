import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/configs/configs.dart';
import 'package:soccer_app/services/services.dart';

class NewsWidget extends StatelessWidget {
  NewsWidget(
      {required this.title,
      required this.date,
      required this.content,
      required this.image_url});
  final title;
  final date;
  final content;
  final image_url;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: screenSize(context).width * .9,
            height: 160,
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 30,
                      child: Text(
                        "${title ?? ''}",
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Config.perpel),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${date ?? ''}"),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 200,
                      height: 100,
                      child: Text(
                        "${content ?? ''}",
                        softWrap: true,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    height: 150,
                    width: 140,
                    child: CachedNetworkImage(
                      imageUrl: image_url.toString(),
                      placeholder: (context, url) =>
                          Image.asset(Config.error_image),
                      errorWidget: (context, url, error) =>
                          Image.asset(Config.error_image),
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Config.yallow,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
