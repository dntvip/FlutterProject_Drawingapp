import 'package:flutter/material.dart';
import 'package:version2/widgets/custom_appbar.dart';
import 'package:version2/widgets/custom_bottomnavigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}