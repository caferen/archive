import '../../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  final double top;

  PasswordField({this.top});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController =
        Provider.of<Authentication>(context).passwordController;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isSignIn = Provider.of<Authentication>(context).isSignIn;
    var auth = Provider.of<Authentication>(context, listen: false);
    return Positioned(
      top: 60 * height / 100 + top,
      left: width / 15,
      width: width,
      child: Container(
        margin: EdgeInsets.fromLTRB(width / 5, 0, width / 5, 0),
        child: TextField(
          controller: passwordController,
          style: TextStyle(color: Colors.white, fontSize: 25),
          onEditingComplete: isSignIn ? () => auth.signIn(context) : null,
          decoration: InputDecoration(
            hintText: 'şifre',
            hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
            border: InputBorder.none,
            isDense: true,
          ),
          obscureText: true,
        ),
      ),
    );
  }
}
