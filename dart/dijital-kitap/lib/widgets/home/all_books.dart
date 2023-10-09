import 'package:dijital_kitap/providers/book.dart';
import 'package:dijital_kitap/providers/books.dart';
import 'package:dijital_kitap/widgets/auth/styled_container.dart';
import 'package:dijital_kitap/widgets/home/book_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Book> bookList = Provider.of<Books>(context).bookList;
    return StyledContainer(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: bookList[index],
            child: BookGridTile(),
          );
        },
      ),
    );
  }
}
