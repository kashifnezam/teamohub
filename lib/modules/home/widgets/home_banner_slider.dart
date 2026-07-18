import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/widgets/custom_widget.dart';

class HomeBannerSlider extends StatefulWidget {
  final List<String> images;
  final bool isNetwork;
  final double height;
  final bool autoPlay;
  final Function(int)? onTap;

  const HomeBannerSlider({
    super.key,
    required this.images,
    this.isNetwork = false,
    this.height = 180,
    this.autoPlay = true,
    this.onTap,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () => widget.onTap?.call(index),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.isNetwork
                      ? CustomWidget.getImage(
                    widget.images[index],
                    height: widget.height,
                    width: double.infinity,
                    shape: BoxShape.rectangle
                  )
                      : Image.asset(
                    widget.images[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            autoPlay: widget.autoPlay,
            enlargeCenterPage: false,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.images.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 8,
            activeDotColor: Colors.indigo,
            dotColor: Colors.grey.shade300,
          ),
        ),

      ],
    );
  }
}