import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    // Keeping the API part as it was
    String url = 'https://newsapi.org/v2/everything?q=apple&from=2023-10-22&to=2023-10-22&sortBy=popularity&apiKey=49f55b16f3f2422ca0c1ba029e3fbef7';

    try {
      var response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if(element['urlToImage'] != null && element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                title: element['title'] ?? '',
                author: element['author'] ?? '',
                description: element['description'] ?? '',
                content: element['content'] ?? '',
                url: element['url'] ?? '',
                urlToImage: element['urlToImage'] ?? ''
              );
              news.add(articleModel);
            }
          });
        }
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}

