import 'package:dijital_kitap/providers/book.dart';
import 'package:dijital_kitap/providers/color.dart';
import 'package:dijital_kitap/providers/home.dart';
import 'package:dijital_kitap/widgets/home/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = Provider.of<Book>(context);
    int index = Provider.of<HomeProvider>(context).index;
    dynamic color = Provider.of<Renk>(context).determineColor(index)[1];
    return Padding(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 6,
          MediaQuery.of(context).size.height / 4,
          MediaQuery.of(context).size.width / 6,
          0),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [color, Colors.black],
                ),
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Hero(
                    tag: book.avatar,
                    child: Image(
                      image: NetworkImage(book.avatar),
                    ),
                  ),
                  Text(
                    '${book.authorFirstName} ${book.authorLastName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${book.authorGender}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${book.categories} - ${book.date}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Text(
                      book.description,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            LikeButton(),
            BackButton(
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
