import '../../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordValidationField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordCheckController =
        Provider.of<Authentication>(context).passwordCheckController;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    var auth = Provider.of<Authentication>(context, listen: false);
    return Positioned(
      top: 60 * height / 100 + 120,
      left: width / 15,
      width: width,
      child: Container(
        margin: EdgeInsets.fromLTRB(width / 5, 0, width / 5, 0),
        child: TextField(
          controller: passwordCheckController,
          style: TextStyle(color: Colors.white, fontSize: 25),
          onEditingComplete: () => auth.signUp(context),
          decoration: InputDecoration(
            hintText: 'şifreyi doğrula',
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
