import 'package:dijital_kitap/providers/book.dart';
import 'package:dijital_kitap/providers/books.dart';
import 'package:dijital_kitap/providers/color.dart';
import 'package:dijital_kitap/providers/home.dart';
import 'package:dijital_kitap/widgets/auth/styled_container.dart';
import 'package:dijital_kitap/widgets/home/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookSearch extends SearchDelegate<Book> {
  final BuildContext context;

  BookSearch(this.context);

  @override
  String get searchFieldLabel => 'Yüzlerce kitabı ara...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    int _selectedIndex = Provider.of<HomeProvider>(context).index;
    var color = Provider.of<Renk>(context).determineColor(_selectedIndex)[0];
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      primaryColor: color,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> bookList = Provider.of<Books>(context).bookList;
    final results = bookList
        .where((b) => b.authorFirstName.toLowerCase().startsWith(query));
    return StyledContainer(
      child: ListView(
        children: results
            .map<Widget>(
              (b) => ListTile(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    fullscreenDialog: true,
                    opaque: false,
                    transitionDuration: Duration(milliseconds: 750),
                    reverseTransitionDuration: Duration(milliseconds: 400),
                    pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
                      value: b,
                      child: DetailCard(),
                    ),
                  ),
                ),
                title: Text(
                  '  ${b.authorFirstName}',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> bookList = Provider.of<Books>(context).bookList;

    final results = bookList
        .where((b) => b.authorFirstName.toLowerCase().startsWith(query));

    return StyledContainer(
      child: query == ""
          ? Center(
              child: Text(
                'Aradıkların burada görünecek.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            )
          : ListView(
              children: results
                  .map<Widget>(
                    (b) => ListTile(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 750),
                          reverseTransitionDuration:
                              Duration(milliseconds: 400),
                          fullscreenDialog: true,
                          opaque: false,
                          pageBuilder: (_, __, ___) =>
                              ChangeNotifierProvider.value(
                            value: b,
                            child: DetailCard(),
                          ),
                        ),
                      ),
                      title: Text(
                        '  ${b.authorFirstName}',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
