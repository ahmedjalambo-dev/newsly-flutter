import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/discover/cubit/discover_cubit.dart';
import 'package:newsly/features/discover/data/repos/discover_repos.dart';
import 'package:newsly/features/discover/data/services/discover_service.dart';
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
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: categories.length, vsync: this);
    super.initState();
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
          title: const Text('News by Category'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: categories.map((c) => Tab(text: c.toUpperCase())).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categories.map((cat) {
            return BlocProvider(
              create: (_) => DiscoverCubit(
                discoverRepo: DiscoverRepo(DiscoverService()),
                category: cat,
              ),
              child: NewsCategoryTab(category: cat),
            );
          }).toList(),
        ));
  }
}
