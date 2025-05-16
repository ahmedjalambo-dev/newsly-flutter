import 'package:flutter/material.dart';
import 'package:newsly/main_navigation.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsly App',
      theme: ThemeData(
        // fontFamily: 'Raleway',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light)
            .copyWith(primary: Colors.blue),
      ),
      home: const MainNavigation(),
    );
  }
}
