// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:recipefinder/core/UI/Screens/home/recipe.dart';
import 'package:recipefinder/core/UI/Screens/home/searchrecipe.dart';
import 'package:recipefinder/core/UI/Screens/home/settings.dart';

List data = [RecipePage(), SearchPage(), SettingsPage()];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange[400],
        unselectedItemColor: Colors.grey[500],
        currentIndex: count,
        onTap: (value) {
          count = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
      body: data[count],
    );
  }
}
