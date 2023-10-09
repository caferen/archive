import 'package:dijital_kitap/providers/book.dart';
import 'package:flutter/material.dart';

class BookTileBar extends StatelessWidget {
  const BookTileBar(this.book);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black54,
      leading: IconButton(
        icon: Icon(!book.isFavorite ? Icons.favorite_border : Icons.favorite),
        onPressed: () => book.toggleFavorite(book),
      ),
      title: Text(book.authorFirstName),
      subtitle: Text(book.categories),
    );
  }
}
