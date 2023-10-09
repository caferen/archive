import 'package:dijital_kitap/providers/book.dart';
import 'package:dijital_kitap/widgets/home/avatar.dart';
import 'package:dijital_kitap/widgets/home/book_tile_bar.dart';
import 'package:dijital_kitap/widgets/home/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookGridTile extends StatelessWidget {
  void seeDetails(BuildContext context, Book book) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 750),
        reverseTransitionDuration: Duration(milliseconds: 400),
        fullscreenDialog: true,
        opaque: false,
        pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
          value: book,
          child: DetailCard(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Book book = Provider.of<Book>(context);
    return GestureDetector(
      onTap: () => seeDetails(context, book),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        child: GridTile(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: Avatar(book),
          ),
          footer: BookTileBar(book),
        ),
      ),
    );
  }
}
