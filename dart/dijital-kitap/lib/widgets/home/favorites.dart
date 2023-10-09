import 'package:dijital_kitap/providers/book.dart';
import 'package:dijital_kitap/providers/books.dart';
import 'package:dijital_kitap/widgets/auth/styled_container.dart';
import 'package:dijital_kitap/widgets/home/book_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Book> favorites = Provider.of<Books>(context).getFavorites;
    return StyledContainer(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: favorites[index],
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              child: BookGridTile(),
            ),
          );
        },
      ),
    );
  }
}
