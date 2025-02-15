import 'package:flutter/material.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFECEDDEE),
      ),
      debugShowCheckedModeBanner: false, // remove debug banner
      routes: {
        "/": (context) => const HomeScreen(),

      },
    );

  }
}