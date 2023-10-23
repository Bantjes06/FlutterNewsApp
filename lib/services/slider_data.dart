import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/models/slider_model.dart';

class Sliders {
// List to hold SliderModel objects
  List<SliderModel> sliders = [];
// Asynchronously fetch sliders)
  Future<void> getSliders() async {
    try {
      String url =
          'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=49f55b16f3f2422ca0c1ba029e3fbef7';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              SliderModel sliderModel = SliderModel(
                  title: element['title'],
                  author: element['author'],
                  description: element['description'],
                  content: element['content'],
                  url: element['url'],
                  urlToImage: element['urlToImage']);
                  print('worked');
              sliders.add(sliderModel);
              
            }
          });
        }
      } else {
        print('Failed to load sliders: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
