import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your custom content above the tab bar
          Container(
            height: 200,
            color: Colors.blue,
            child: const Center(child: Text('Custom Content Area')),
          ),

          // The tab bar
          Container(
            color: Colors.white, // Background color of tab bar
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                const Tab(text: 'Tab 1'),
                const Tab(text: 'Tab 2'),
                const Tab(text: 'Tab 3'),
              ],
            ),
          ),

          // Tab bar view
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const Center(child: Text('Content of Tab 1')),
                const Center(child: Text('Content of Tab 2')),
                const Center(child: Text('Content of Tab 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
