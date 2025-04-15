import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/features/categories/cubit/category_cubit.dart';
import 'package:newsly/features/categories/ui/widgets/category_tab_bar.dart';
import 'package:newsly/features/categories/ui/widgets/news_category_tab_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: selectedIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          ' Categories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Animated Custom Tab Bar
          CategoryTabBar(
            categories: categories,
            selectedIndex: selectedIndex,
            tabController: _tabController,
            onTabChanged: (index) {
              setState(() => selectedIndex = index);
              _tabController.animateTo(index);
            },
          ),
          // IndexedStack for Pages
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: categories.map((cat) {
                return BlocProvider(
                  key: ValueKey(cat), // keep state alive per tab
                  create: (_) => getIt<CategoryCubit>(param1: cat),
                  child: NewsCategoryTabView(category: cat),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
