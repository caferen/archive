import '../../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isSignIn = Provider.of<Authentication>(context).isSignIn;
    var auth = Provider.of<Authentication>(context, listen: false);
    return Positioned(
      left: 20 * width / 24,
      top: 80 * height / 100,
      child: IconButton(
        icon: Icon(Icons.arrow_forward, color: Colors.white70, size: 30),
        onPressed:
            isSignIn ? () => auth.signIn(context) : () => auth.signUp(context),
      ),
    );
  }
}
