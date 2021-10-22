import 'package:soccer_app/models/news_model.dart';
import 'package:soccer_app/providers/base_provider.dart';
import 'package:wordpress_api/wordpress_api.dart';

class WordpressContentProvider extends BaseProvider {
  List<NewsModel> news = List.empty(growable: true);
  String baseUrl = 'https://jongsintgillis.be/';

  Future<List<NewsModel>> loadNews() async {
    final api = WordPressAPI(baseUrl);

    final WPResponse res = await api.posts.fetch();
    for (Post post in res.data) {
      print("lenght ${post.content?.length}");
      NewsModel model = NewsModel(
          title: post.title,
          content: post.content.toString(),
          date: post.dateGmt);
      print(model.content?.length);
      news.add(model);
    }
    print(news.length);
    notifyListeners();
    return news;
  }

  loadCategories() async {}
}
