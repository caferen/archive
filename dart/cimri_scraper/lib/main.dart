import 'package:flutter/material.dart';
import './results.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cimri Scraper',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.blueAccent[100],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  String url;

  @override
  void initState() {
    super.initState();
    textController.addListener(_changeUrl);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  _changeUrl() {
    url = textController.text;
  }

  Widget error = SimpleDialog(
    title: Text(
      'Error!',
      textAlign: TextAlign.center,
    ),
    children: [
      Text(
        'Item name not detected.',
        textAlign: TextAlign.center,
      )
    ],
    contentPadding: EdgeInsets.all(30),
    elevation: 10,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (url.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  link: url,
                ),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) => error,
              barrierDismissible: true,
            );
          }
        },
        shape: RoundedRectangleBorder(),
        label: Text('Fetch Data'),
        backgroundColor: Theme.of(context).accentColor,
        icon: Icon(Icons.send),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: textController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.textsms),
              //prefix: CircularProgressIndicator(),
              hintText: 'Enter item name to search at cimri.com: ',
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
