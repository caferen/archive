import 'package:dijital_kitap/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  bool _isSignIn = true;
  String _email;
  String _password;
  String _passwordCheck;
  User _user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  bool get isSignIn => _isSignIn;

  User get currentUser => _user;

  TextEditingController get emailController {
    _emailController.addListener(() => _email = _emailController.text);
    return _emailController;
  }

  TextEditingController get passwordController {
    _passwordController.addListener(() => _password = _passwordController.text);

    return _passwordController;
  }

  TextEditingController get passwordCheckController {
    _passwordCheckController
        .addListener(() => _passwordCheck = _passwordCheckController.text);

    return _passwordCheckController;
  }

  void switchAuth() {
    _isSignIn = !_isSignIn;
    notifyListeners();
  }

  void setUser(User user) => _user = user;

  void signIn(BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      setUser(FirebaseAuth.instance.currentUser);
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
        (route) => false,
      );
    } catch (e) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(Icons.error),
              SizedBox(width: 30),
              Flexible(
                  child: Text(e.message != null ? e.message : e.toString())),
            ],
          ),
        ),
      );
    }
  }

  void signUp(BuildContext ctx) async {
    try {
      if (_password != _passwordCheck) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Icon(Icons.error),
                SizedBox(width: 30),
                Flexible(
                  child: Text('Şifreler eşleşmiyor!'),
                ),
              ],
            ),
          ),
        );
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      setUser(FirebaseAuth.instance.currentUser);
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
        (route) => false,
      );
    } catch (e) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(Icons.error),
              SizedBox(width: 30),
              Flexible(
                  child: Text(e.message != null ? e.message : e.toString())),
            ],
          ),
        ),
      );
    }
  }
}
