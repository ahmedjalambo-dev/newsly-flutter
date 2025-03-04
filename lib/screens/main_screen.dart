import 'package:flutter/material.dart';
import 'package:newsly/screens/widgets/icon_button_widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('GoogleNavBar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                const GButton(
                  icon: Icons.bookmark,
                  text: 'Likes',
                ),
                const GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                const GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          //  menu button
          IconButtonWidget(
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
          spacing: 8,
          children: [
            // search news button
            IconButtonWidget(
              icon: Icons.search_rounded,
              onPressed: () {},
            ),
            // notification news button
            IconButtonWidget(
              icon: Icons.notifications_none_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Breaking News
        const Text(
          'Breaking News',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),

        // View more
        TextButton(onPressed: () {}, child: const Text('Show all'))
      ],
    ),
  );
}
