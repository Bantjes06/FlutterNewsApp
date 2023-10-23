import 'package:http/http.dart' as http;
import 'package:news_app/models/show_category.dart';
import 'dart:convert';

class ShowCategoryNews {
//List to hold ShowCategoryModel objects
  List<ShowCategoryModel> categories = [];

// Asynchronously fetch category-specific news from the API
  Future<void> getCategoriesNews(String category) async {
// Define the API endpoint with the category parameter
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=49f55b16f3f2422ca0c1ba029e3fbef7';
// Fetch data from the API
    var response = await http.get(Uri.parse(url));
// Parse the JSON response
    var jsonData = jsonDecode(response.body);
// Check for successful API status
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if(element['urlToImage'] != null && element['description'] != null) {
          ShowCategoryModel showCategoryModel = ShowCategoryModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            content: element['content'],
            url: element['url'],
            urlToImage: element['urlToImage']
          );
// Add the ShowCategoryModel object to the categories lis
          categories.add(showCategoryModel);
        }
      },);
    }
  }
}