import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getNews();
    getSliders();
    super.initState();
  }

// Asynchronously fetch news data
  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    setState(() {
      articles = newsclass.news;
    });
  }

// Asynchronously fetch sliders data
  getSliders() async {
    Sliders slider = Sliders();
    await slider.getSliders();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news = " News",
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
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              widget.news == "Breaking" ? sliders.length : articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              title: widget.news == "Breaking"
                  ? sliders[index].title!
                  : articles[index].title!,
              desc: widget.news == "Breaking"
                  ? sliders[index].description!
                  : articles[index].description!,
              image: widget.news == "Breaking"
                  ? sliders[index].urlToImage!
                  : articles[index].urlToImage!,
              url: widget.news == "Breaking"
                  ? sliders[index].url!
                  : articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String image, title, desc, url;
  AllNewsSection(
      {super.key,
      required this.title,
      required this.image,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
// Navigate to ArticleView when tapped
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
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
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
