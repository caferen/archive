import 'package:flutter/material.dart';

class SloganText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Positioned(
      left: width / 3,
      top: 26 * height / 100,
      child: Text(
        'okumanın yeni yolu',
        style: TextStyle(color: Colors.white54, fontSize: 20),
      ),
    );
  }
}
