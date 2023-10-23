import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/all_news.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/pages/category_news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/services/news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  int activeIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    categories = getCategories();
    getSliders();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      //_loading = false;
    });
  }

  getSliders() async {
    Sliders slider = Sliders();
    await slider.getSliders();
    sliders = slider.sliders;
    setState(() {  // Add setState here
    
    _loading = false; // You can also update the loading state here if required
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Breaking News",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllNews(news: "Breaking"),
                              ),
                            );
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CarouselSlider.builder(
                    itemCount: sliders.length, // Dynamic length
                    itemBuilder: (context, index, realIndex) {
                      if (index < sliders.length) {
                        // Safety check
                        String? res = sliders[index].urlToImage;
                        String? res1 = sliders[index].title;
                        return buildImage(res!, index, res1!);
                      } else {
                        return Container(
                          child: Center(child: const Text('No data')),
                        ); // Placeholder
                      }
                    },
                    options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(child: buildIndicator()),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trending Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllNews(news: "Trending"),
                              ),
                            );
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              title: articles[index].title!,
                              desc: articles[index].description!,
                              imageUrl: articles[index].urlToImage!,
                              url: articles[index].url!);
                        }),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(top: 170),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const SlideEffect(
            activeDotColor: Colors.red, dotWidth: 15, dotHeight: 15),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;

  BlogTile(
      {super.key,
      required this.title,
      required this.desc,
      required this.imageUrl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            desc,
                            maxLines: 3,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
