import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  String name;

  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
//List to hold the category news
  List<ShowCategoryModel> categories = [];
//A loading indicator flag
  bool _loading = true;

  @override
  void initState() {
  // Fetch news when the state is initialized
    getNews();
    super.initState();
  }

// Asynchronously fetch category-specific news
  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ShowCategory(
              title: categories[index].title!,
              desc: categories[index].description!,
              image: categories[index].urlToImage!,
              url: categories[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, title, desc, url;
  ShowCategory(
      {super.key,
      required this.title,
      required this.image,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
