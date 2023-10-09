import 'package:dijital_kitap/providers/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/books.dart';
import 'providers/color.dart';
import 'screens/auth.dart';

void main() => runApp(DijitalKitap());

class DijitalKitap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Books(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Renk(),
        ),
      ],
      child: MaterialApp(
        title: 'DijitalKitap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.black,
          textTheme: Typography.whiteMountainView,
        ),
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.done
                  ? Auth()
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }
}
