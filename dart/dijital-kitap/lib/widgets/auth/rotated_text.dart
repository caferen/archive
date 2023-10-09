import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class RotatedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isSignIn = Provider.of<Authentication>(context).isSignIn;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Positioned(
      left: width / 17,
      top: height / 10,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          isSignIn ? 'giriş yap' : 'kaydol',
          style: TextStyle(color: Colors.white38, fontSize: 50),
        ),
      ),
    );
  }
}
