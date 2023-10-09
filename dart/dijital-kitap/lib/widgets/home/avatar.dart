import 'package:dijital_kitap/providers/book.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(this.book);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: book.avatar,
      child: Image.network(
        book.avatar,
        errorBuilder: (_, __, ___) => Text('😢'),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}
