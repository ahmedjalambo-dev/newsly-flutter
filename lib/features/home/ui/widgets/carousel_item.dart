import 'package:flutter/material.dart';
import 'package:newsly/features/home/ui/widgets/overlay_color.dart';

class CarouselItem extends StatelessWidget {
  final String item;
  const CarouselItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 5),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // image of news
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                // black overlay
                const OverlayColor()
              ],
            ),
          ),
        ),

        // category type
        PositionedDirectional(
          top: 20,
          start: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text('Sports', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),

        // source name - time
        const PositionedDirectional(
          bottom: 70,
          start: 20 - 15,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Text('CNN - 6 hours ago',
                style: TextStyle(color: Colors.white)),
          ),
        ),

        // title of news
        PositionedDirectional(
          bottom: 20,
          start: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                'Alexander wears modified helmet in road races',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
