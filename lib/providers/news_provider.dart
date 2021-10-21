import 'package:soccer_app/models/news_model.dart';
import 'package:soccer_app/providers/base_provider.dart';
import 'package:wordpress_api/wordpress_api.dart';

class WordpressContentProvider extends BaseProvider {
  List<NewsModel> news = List.empty(growable: true);
  String baseUrl = 'https://jongsintgillis.be/';

  loadNews() async {
    final api = WordPressAPI(baseUrl);
    final WPResponse res = await api.posts.fetch();
    for (Post post in res.data) {
      print(post..featuredMedia.toString());
      news.add(NewsModel(
          title: post.title,
          content: WPUtils.parseHtml(post.content),
          date: post.dateGmt));
    }
    notifyListeners();
  }

  loadCategories() async {}
}
