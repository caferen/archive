import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Positioned(
      left: width / 3,
      top: 20 * height / 100,
      child: Text(
        'dijital kitap',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}
