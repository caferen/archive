import 'package:flutter/material.dart';

class WaveTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      style: TextStyle(color: Colors.white, fontSize: 25),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Başlık',
        hintStyle: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
