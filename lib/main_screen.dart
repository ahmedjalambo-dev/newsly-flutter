import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/home/cubit/topheadlines_cubit.dart';
import 'package:newsly/features/home/db/repos/topheadline_repo.dart';
import 'package:newsly/features/home/db/services/topheadline_service.dart';
import 'package:newsly/features/home/ui/screens/home_screen.dart';
import 'package:newsly/features/profile/ui/screens/profile_screen.dart';
import 'package:newsly/features/saved/ui/screens/saved_screen.dart';
import 'package:newsly/features/search/ui/screens/search_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    BlocProvider(
      create: (context) => TopheadlinesCubit(
        topHeadlineRepo: TopHeadlineRepo(
          topheadlineService: TopheadlineService(),
        ),
      )..fetchTopHeadlines(),
      child: const HomeScreen(),
    ),
    const SavedScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens.elementAt(_selectedIndex),
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
                  icon: Icons.bookmark_rounded,
                  text: 'Saved',
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
