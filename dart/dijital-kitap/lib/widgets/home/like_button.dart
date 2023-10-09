import 'package:dijital_kitap/providers/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = Provider.of<Book>(context);
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      end: 5,
      child: IconButton(
        icon: Icon(
          book.isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () =>
            Provider.of<Book>(context, listen: false).toggleFavorite(book),
      ),
    );
  }
}
