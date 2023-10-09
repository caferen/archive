import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class SwitchScreenText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isSignIn = Provider.of<Authentication>(context).isSignIn;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Positioned(
      left: 9 * width / 24,
      top: 90 * height / 100,
      child: RichText(
        text: TextSpan(
          text: isSignIn
              ? 'hesabın yok mu? hemen kaydol!'
              : 'zaten hesabın var mı ? giriş yap!',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 17,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap =
                Provider.of<Authentication>(context, listen: false).switchAuth,
        ),
      ),
    );
  }
}
