import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:scraper_ui/web_view.dart';
import 'item.dart';
import 'package:html/parser.dart';

class ItemsList extends StatelessWidget {
  final List<Item> items;

  ItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(),
        label: Text('Back to Search'),
        backgroundColor: Theme.of(context).accentColor,
        icon: Icon(Icons.arrow_back),
      ),
      body: ListView(children: [
        DataTable(
          columns: [
            DataColumn(
                label: Text('Title',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Price',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: items
              .map(
                ((element) => DataRow(
                      cells: [
                        DataCell(FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CimriWebView(link2: element.link),
                              ),
                            );
                          },
                          child: Text(element.title),
                        )),
                        DataCell(Text(element.price)),
                      ],
                    )),
              )
              .toList(),
        ),
      ]),
    );
  }
}

class ResultsPage extends StatefulWidget {
  final String link;
  ResultsPage({Key key, @required this.link}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState(link);
}

class _ResultsPageState extends State<ResultsPage> {
  final String link;

  _ResultsPageState(this.link);

  List<Item> items = [];
  

  List<Item> parseItems(String responseBody) {
    var document = parse(responseBody);
    List cimriItems = document.querySelectorAll('#cimri-product');
    for (var item in cimriItems) {
      var title = item.querySelector('.product-title').attributes['title'];
      var price = "32"; //item.querySelector('.top-offer > .s14oa9nh-0 fFCyge').text;
      var link = "https://www.cimri.com" +
          item.querySelector('.link-detail').attributes['href'];
      var newItem = new Item(link: link, title: title, price: price);
      items.add(newItem);
    }
    return items;
  }

  Future<List<Item>> fetchItems(http.Client client) async {
    String link2 = "https://www.cimri.com/arama?q=" + link;
    Response response = await client
        .get(link2);

    return parseItems(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: fetchItems(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ItemsList(items: snapshot.data);
          } else {
            return Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              body: Center(
                child: SpinKitFadingCube(
                  color: Theme.of(context).primaryColor,
                  size: 100.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
