import 'package:dijital_kitap/providers/home.dart';
import 'package:dijital_kitap/widgets/home/bottom_navigation.dart';
import 'package:dijital_kitap/widgets/home/drawer.dart';
import 'package:dijital_kitap/widgets/home/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: SearchBar(),
      drawer: Cekmece(),
      body: Provider.of<HomeProvider>(context).homeBody,
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
