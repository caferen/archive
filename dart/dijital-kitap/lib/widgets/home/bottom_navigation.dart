import 'package:dijital_kitap/providers/home.dart';
import 'package:flutter/material.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<HomeProvider>(context).index;
    return GradientBottomNavigationBar(
      backgroundColorStart: Colors.teal[700],
      backgroundColorEnd: Colors.deepPurple[900],
      currentIndex: _selectedIndex,
      onTap: (index) =>
          Provider.of<HomeProvider>(context, listen: false).toggleIndex(index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Ana menü'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favoriler'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profil'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Ayarlar'),
        ),
      ],
    );
  }
}
