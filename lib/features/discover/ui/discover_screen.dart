import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/features/discover/cubit/discover_cubit.dart';
import 'package:newsly/features/discover/data/repos/discover_repos.dart';
import 'package:newsly/features/discover/ui/widgets/news_category_tab.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
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
          'Discover',
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          setState(() => selectedIndex = index);
                          _tabController.animateTo(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            '${categories[index][0].toUpperCase()}${categories[index].substring(1)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // IndexedStack for Pages
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: categories.map((cat) {
                return BlocProvider(
                  key: ValueKey(cat), // keep state alive per tab
                  create: (_) => DiscoverCubit(
                    discoverRepo: getIt<DiscoverRepo>(),
                    category: cat,
                  ),
                  child: NewsCategoryTab(category: cat),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
