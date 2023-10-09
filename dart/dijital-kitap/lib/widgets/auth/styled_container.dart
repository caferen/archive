import 'package:dijital_kitap/providers/color.dart';
import 'package:dijital_kitap/providers/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;

  const StyledContainer({this.child});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    int _selectedIndex = Provider.of<HomeProvider>(context).index;
    var color = Provider.of<Renk>(context).determineColor(_selectedIndex)[0];
    var secondColor =
        Provider.of<Renk>(context).determineColor(_selectedIndex)[1];
    return SingleChildScrollView(
      child: Builder(
        builder: (context) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color,
                secondColor,
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
