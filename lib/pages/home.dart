import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List WallpaperImages = [
  'images/Wallpaper3.jpg',
  'images/Wallpaper2.jpg',
  'images/Wallpaper1.jpg'
];
int activeIndex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 65, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      'images/logo.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  'Wallpaper',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              itemCount: WallpaperImages.length,
              itemBuilder: (context, index, realIndex) {
                final res = WallpaperImages[index];
                return buildImages(res, index);
              },
              options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height / 1.5,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, season) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: buildIndicator())
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );

  Widget buildImages(String urlImage, int index) => SizedBox(
        //margin: EdgeInsets.only(right: 0),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              urlImage,
              fit: BoxFit.cover,
            )),
      );
}
