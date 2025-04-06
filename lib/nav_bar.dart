import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';
import 'package:newsly/features/home/data/services/news_service.dart';
import 'package:newsly/features/home/ui/screens/home_screen.dart';
import 'package:newsly/features/settings/ui/screens/settings_screen.dart';
import 'package:newsly/features/discover/ui/screens/discover_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // Create the cubit once
  final HomeCubit _homeCubit = HomeCubit(
    newsRepo: NewsRepo(
      newsService: NewsService(),
    ),
  )..fetchNews();

  @override
  void dispose() {
    _homeCubit.close(); // Don't forget to close the cubit
    super.dispose();
  }

  static List<Widget> _buildScreens(HomeCubit homeCubit) {
    return <Widget>[
      BlocProvider.value(
        value: homeCubit,
        child: const HomeScreen(),
      ),
      const DiscoverScreen(),
      const DiscoverScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildScreens(_homeCubit).elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black26,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue,
              color: Colors.grey,
              tabs: [
                const GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                ),
                const GButton(
                  icon: Icons.bookmark_outlined,
                  text: 'Bookmarks',
                ),
                const GButton(
                  icon: Icons.language_rounded,
                  text: 'Discover',
                ),
                const GButton(
                  icon: Icons.settings,
                  text: 'Settings',
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
