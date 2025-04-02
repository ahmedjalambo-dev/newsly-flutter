import 'package:flutter/material.dart';
import 'package:newsly/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsly App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      home: const MainScreen(),
    );
  }
}
