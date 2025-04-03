import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/home/bloc/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';
import 'package:newsly/features/home/data/services/news_service.dart';
import 'package:newsly/features/home/ui/screens/home_screen.dart';
import 'package:newsly/features/profile/ui/screens/profile_screen.dart';
import 'package:newsly/features/saved/ui/screens/discover_screen.dart';
import 'package:newsly/features/discover/ui/screens/discover_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  static List<Widget> _buildScreens(HomeCubit homeCubit) => <Widget>[
        BlocProvider.value(
          value: homeCubit,
          child: const HomeScreen(),
        ),
        const DiscoverScreen(),
        const SearchScreen(),
        const ProfileScreen(),
      ];

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
                  icon: Icons.bookmark,
                  text: 'Bookmarks',
                ),
                const GButton(
                  icon: Icons.search,
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
