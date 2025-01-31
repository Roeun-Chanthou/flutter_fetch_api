import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/slider.dart';

class BuildSlider extends StatefulWidget {
  const BuildSlider({super.key});

  @override
  State<BuildSlider> createState() => _BuildSliderState();
}

class _BuildSliderState extends State<BuildSlider> {
  int currentIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CarouselSlider(
          items: slides.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade300,
                  ),
                  child: Image.network(
                    i,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
          carouselController: controller,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.easeInQuad,
            enlargeCenterPage: true,
            aspectRatio: 2,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: slides.length,
          effect: ExpandingDotsEffect(
            dotColor: Colors.grey[300]!,
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
      ],
    );
  }
}
