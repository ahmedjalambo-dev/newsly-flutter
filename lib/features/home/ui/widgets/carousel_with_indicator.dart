import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> items;

  const CarouselWithIndicator({super.key, required this.items});

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;

  @override
  bool get wantKeepAlive => true; // Keep the widget alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to enable keep-alive
    return Column(
      children: [
        CarouselSlider(
          items: widget.items, // Use precomputed items
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.map((item) {
            int index = widget.items.indexOf(item);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _current == index
                  ? 16.0
                  : 8.0, // Make the width larger for the oval
              height: 8.0, // Keep the height constant
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    16.0), // Add borderRadius for oval shape
                color: _current == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
