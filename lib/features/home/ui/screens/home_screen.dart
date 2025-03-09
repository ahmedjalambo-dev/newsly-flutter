import 'package:flutter/material.dart';
import 'package:newsly/features/home/ui/widgets/carousel_item.dart';
import 'package:newsly/features/home/ui/widgets/carousel_with_indicator.dart';
import 'package:newsly/features/home/ui/widgets/category_tile.dart';
import 'package:newsly/features/home/ui/widgets/circle_icon_button.dart';
import 'package:newsly/features/home/ui/widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController carouselController = CarouselController();
  int current = 0;
  final List<String> dummyImages = [
    'assets/images/bn1.png',
    'assets/images/bn2.png',
    'assets/images/bn3.png',
    'assets/images/bn4.png',
    'assets/images/bn5.png',
  ];

  @override
  Widget build(BuildContext context) {
    // Create image slider widgets from the dummy images
    final List<Widget> imageSliders =
        dummyImages.map((item) => CarouselItem(item: item)).toList();

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const CategoryTile(
              categoryName: 'Breaking News',
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.6,
              child: CarouselWithIndicator(
                items: imageSliders,
                aspectRatio: 16 / 8,
                itemList: dummyImages,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            const CategoryTile(
              categoryName: 'Recommendation',
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyImages.length,
              itemBuilder: (context, index) =>
                  NewsTile(index: index, dummyImages: dummyImages),
            ),
          ],
        ),
      ),
    );
  }

  // appbar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            CircleIconButton(
              icon: Icons.menu_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              CircleIconButton(
                icon: Icons.search_rounded,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              CircleIconButton(
                icon: Icons.notifications_none_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
