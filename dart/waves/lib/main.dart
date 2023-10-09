import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liner_waves/edit_wave.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'providers/wave_state_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(Waves());
}

class Waves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Wave(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Waves',
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            elevation: 15,
            unselectedItemColor: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black87,
              size: 30,
            ),
          ),
        ),
        home: LinerScreen(),
      ),
    );
  }
}

class LinerScreen extends StatefulWidget {
  final File wave;

  LinerScreen({this.wave});

  @override
  _LinerScreenState createState() => _LinerScreenState();
}

class _LinerScreenState extends State<LinerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu_open), onPressed: () {}),
        title: Row(
          children: [
            Expanded(child: SizedBox()),
            Container(
              child: FlatButton(
                  child: Text(
                    'Liner',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {}),
              height: 25,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 2, color: Colors.blue),
                ),
              ),
            ),
            FlatButton(
                child: Text(
                  'Wave',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {}),
            Expanded(child: SizedBox(), flex: 2),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: widget.wave != null
            ? Center(child: Image.file(widget.wave))
            : Center(child: Text('Fotoğraf yok')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) => toggleIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '1',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '1',
            activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '1',
            activeIcon: Icon(Icons.add_box),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: '1',
            activeIcon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '1',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  int _selectedIndex = 0;
  void toggleIndex(int index) {
    index == 2 ? _takePhoto() : setState(() => _selectedIndex = index);
  }

  File _storedPhoto;
  Future<void> _takePhoto() async {
    final photo = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() => _storedPhoto = File(photo.path));

    final appDir = await getApplicationDocumentsDirectory();

    final fileName = path.basename(photo.path);

    final savedPhoto = await _storedPhoto.copy('${appDir.path}/$fileName');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => Wave(),
          child: Builder(
            builder: (context) => EditWave(savedPhoto),
          ),
        ),
      ),
    );
  }
}
