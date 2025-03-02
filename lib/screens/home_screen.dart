import 'package:flutter/material.dart';
import 'package:newsly/screens/widgets/icon_button_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildAppBar(),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  menu button
          IconButtonWidget(icon: Icons.menu_rounded, onPressed: () {}),
          Row(
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
        ],
      ),
    );
  }
}
