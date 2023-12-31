import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:soru_takip/widgets/drawer.dart';
import 'package:soru_takip/widgets/body.dart';
import 'package:soru_takip/widgets/widgets.dart';
import 'package:intl/intl.dart';

void main() => runApp(SoruTakip());

class SoruTakip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soru Takip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.black,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final soruSayisiController = TextEditingController();
  final yanlisSayisiController = TextEditingController();
  String _soruSayisi;
  String _yanlisSayisi;
  String _dersAdi;
  DateTime _tarih;
  String strTarih;
  String isim = 'second';
  Color firstIcon = Colors.white;
  Color secondIcon = Colors.blue;
  List<String> dersListesi = [
    'Matematik',
    'Fen',
    'Türkçe',
    'Sosyal',
    'İngilizce'
  ];
  bool isSumVisible = false;
  bool isDailyVisible = false;

  @override
  void initState() {
    super.initState();
    soruSayisiController.addListener(changeSoruSayisi);
    yanlisSayisiController.addListener(changeYanlisSayisi);
  }

  @override
  void dispose() {
    soruSayisiController.dispose();
    yanlisSayisiController.dispose();
    super.dispose();
  }

  changeSoruSayisi() {
    _soruSayisi = soruSayisiController.text;
  }

  changeYanlisSayisi() {
    _yanlisSayisi = yanlisSayisiController.text;
  }

  void ekle(
    BuildContext ctx,
    String soruSayisi,
    String yanlisSayisi,
    String dersAdi,
    String strTarih,
    DateTime tarih,
  ) {
    if (soruSayisi == null ||
        yanlisSayisi == null ||
        dersAdi == null ||
        strTarih == null) {
      Scaffold.of(ctx).showSnackBar(
          SnackBar(content: Center(child: Text('Girdilerden birisi boş!'))));
    } else {
      var db = Firestore.instance
          .collection(isim)
          .document('${strTarih.replaceAll('/', ' ')} $dersAdi');
      int soru = int.parse(soruSayisi);
      int yanlis = int.parse(yanlisSayisi);
      db.setData({
        'soruSayisi': FieldValue.increment(soru),
        'yanlisSayisi': FieldValue.increment(yanlis),
        'dersAdi': dersAdi,
        'strTarih': strTarih,
        'tarih': tarih,
      }, merge: true);

      setState(() {
        _dersAdi = null;
        _tarih = null;
      });
      Navigator.pop(ctx);
    }
  }

  Widget dropdownMenu() {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Center(
          child: DropdownButton<String>(
            hint: Text(
              'Ders',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            value: _dersAdi,
            icon: Icon(Icons.arrow_downward, color: Colors.black),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 20),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (newValue) {
              setState(() {
                _dersAdi = newValue;
              });
            },
            items: dersListesi.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void addSoruSheet(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.cyan[600],
      context: ctx,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return FlatButton(
                    color: Colors.transparent,
                    onPressed: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    ).then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      }
                      setState(() {
                        _tarih = pickedDate;
                        strTarih = DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: _tarih == null
                          ? Icon(Icons.date_range, size: 40)
                          : Text(strTarih, style: TextStyle(fontSize: 20)),
                    ),
                  );
                },
              ),
            ),
            textInput(
                controller: soruSayisiController,
                hintText: 'Soru Sayısı',
                keyboardType: TextInputType.number),
            textInput(
                controller: yanlisSayisiController,
                hintText: 'Yanlış Sayısı',
                keyboardType: TextInputType.number),
            dropdownMenu(),
            FlatButton(
                color: Colors.transparent,
                onPressed: () => ekle(
                      context,
                      _soruSayisi,
                      _yanlisSayisi,
                      _dersAdi,
                      strTarih,
                      _tarih,
                    ),
                child: Icon(Icons.playlist_add, size: 40)),
          ],
        );
      },
    );
  }

  void _navigate(int index) {
    setState(() {
      if (index == 0) {
        first
      Icon = Colors.white;
        secondIcon = Colors.blue;
        isim = 'second';
        dersListesi = [
          'Matematik',
          'Fen',
          'Türkçe',
          'Sosyal',
          'İngilizce',
        ];
      } else {
        first
      Icon = Colors.blue;
        secondIcon = Colors.white;
        isim = 'first
      ';
        dersListesi = [
          'Matematik',
          'Geometri',
          'Fizik',
          'Kimya',
          'Biyoloji',
          'Türkçe',
          'Sosyal Bilimler',
        ];
      }
    });
  }

  Stream<QuerySnapshot> get data {
    return Firestore.instance.collection(isim).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: data,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return loading(context);
        }
        return Scaffold(
          backgroundColor: Colors.teal[300],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () => addSoruSheet(context),
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.black,
              );
            },
          ),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            elevation: 10,
            actions: [
              FlatButton(
                onPressed: () =>
                    setState(() => isDailyVisible = !isDailyVisible),
                child: Text(
                    !isDailyVisible
                        ? 'Günlük veriyi göster'
                        : 'Günlük veriyi sakla',
                    style: TextStyle(
                        color: !isDailyVisible ? Colors.white : Colors.black)),
              ),
              FlatButton(
                onPressed: () => setState(() => isSumVisible = !isSumVisible),
                child: Text(
                    !isSumVisible
                        ? 'Toplam veriyi göster'
                        : 'Toplam veriyi sakla',
                    style: TextStyle(
                        color: !isSumVisible ? Colors.white : Colors.black)),
              ),
            ],
          ),
          drawer: Cekmece(),
          body: Body(
            dersListesi,
            isim,
            isDailyVisible,
            isSumVisible,
            snapshot.data,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            elevation: 25,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  child: Row(children: [
                    Icon(Icons.school, color: secondIcon),
                    Text('   second', style: TextStyle(color: secondIcon)),
                  ]),
                  onPressed: () => _navigate(0),
                ),
                FlatButton(
                  child: Row(
                    children: [
                      Text('first
                       ', style: TextStyle(color: first
                    Icon)),
                      Icon(Icons.school, color: first
                    Icon),
                    ],
                  ),
                  onPressed: () => _navigate(1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
