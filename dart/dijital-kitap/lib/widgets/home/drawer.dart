import 'package:dijital_kitap/providers/color.dart';
import 'package:dijital_kitap/providers/home.dart';
import 'package:dijital_kitap/screens/auth.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cekmece extends StatelessWidget {
  void sendEmail() async {
    await EmailLauncher.launch(
      Email(
        to: ['someone@gmail.com'],
        cc: ['someoneelse@gmail.com'],
        subject: 'Dijital Kitap uygulaması bug bildirimi',
        body:
            'Bulduğunuz hatayı detaylı bir şekilde açıklayınız. Gerektiği yerlerde lütfen ekran görüntüsü ekleyiniz',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<HomeProvider>(context).index;
    var color = Provider.of<Renk>(context).determineColor(index)[0];

    return Drawer(
      elevation: 5,
      child: ListView(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Dijital Kitap',
                style: TextStyle(fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color, Colors.black])),
          ),
          FlatButton(
            onPressed: () => sendEmail(),
            child: Row(
              children: [
                Icon(Icons.bug_report),
                SizedBox(width: 10),
                Text('Bug Bildir'),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Dijital Kitap',
              applicationVersion: '0.0.3',
              applicationIcon: Icon(Icons.book),
            ),
            child: Row(
              children: [
                Icon(Icons.more_horiz),
                SizedBox(width: 10),
                Text('Hakkında'),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => FirebaseAuth.instance.signOut().then((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Auth(),
                  ),
                  (route) => false);
            }),
            child: Row(
              children: [
                Icon(Icons.exit_to_app_sharp),
                SizedBox(width: 10),
                Text('Çıkış yap'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
