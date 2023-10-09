import 'package:dijital_kitap/widgets/auth/styled_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstTime extends StatefulWidget {
  final User user;

  const FirstTime(this.user);
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StyledContainer(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                left: width / 4,
                top: height / 8,
                child: Text(
                  'Dijital Kitap\'a hoşgeldin!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Positioned(
                left: width / 4 - 25,
                top: height / 8 + 50,
                child: Text(
                  'Profilini oluşturarak başlayalım.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Positioned(
                left: width / 8,
                top: height / 3,
                child: Container(
                  width: width / 4,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'İsim boş olamaz!' : null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: 'İsim',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: width / 8,
                top: height / 3,
                child: Container(
                  width: width / 4,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Soyisim boş olamaz!' : null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Soyisim',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width / 8,
                top: height / 3 + 150,
                child: Container(
                  width: width,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Kullanıcı boş olamaz!' : null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı adı',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width / 8,
                top: height / 3 + 300,
                child: Container(
                  width: width,
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Doğum tarihi boş olamaz!' : null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Doğum tarihi',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height / 3 + 400,
                left: width / 4,
                child: Container(
                  width: width / 2,
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // create user
                      }
                    },
                    child: Text(
                      'Kaydet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
