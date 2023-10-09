import 'package:flutter/foundation.dart';

class Book with ChangeNotifier {
  final int id;
  final String authorFirstName;
  final String authorLastName;
  final String description;
  final String date;
  final String authorGender;
  final int authorAge;
  final String avatar;
  final String categories;
  bool isFavorite;

  Book({
    @required this.id,
    @required this.authorFirstName,
    @required this.authorLastName,
    @required this.description,
    @required this.date,
    @required this.authorGender,
    @required this.authorAge,
    @required this.avatar,
    @required this.categories,
    this.isFavorite = false,
  });

  void toggleFavorite(Book book) {
    book.isFavorite = !book.isFavorite;
    notifyListeners();
  }
}
