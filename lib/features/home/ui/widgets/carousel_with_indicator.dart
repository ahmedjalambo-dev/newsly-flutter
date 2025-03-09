import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> items;
  final List<dynamic> itemList;
  final double aspectRatio;
  final bool autoPlay;
  final bool enlargeCenterPage;

  const CarouselWithIndicator({
    super.key,
    required this.items,
    required this.itemList,
    this.aspectRatio = 2.0,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
  });

  @override
  State<StatefulWidget> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: widget.items,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: widget.autoPlay,
                enlargeCenterPage: widget.enlargeCenterPage,
                aspectRatio: widget.aspectRatio,
                onPageChanged: (index, reason) =>
                    setState(() => _current = index)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.itemList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _current == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  color: _current == entry.key
                      ? Colors.blue
                      : Colors.grey.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
