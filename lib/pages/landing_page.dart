import 'package:flutter/material.dart';
import 'package:news_app/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'images/building.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'News from around\n the world for you!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Read more about the world.',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 5.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
