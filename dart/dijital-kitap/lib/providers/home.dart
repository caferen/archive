import 'package:dijital_kitap/widgets/home/all_books.dart';
import 'package:dijital_kitap/widgets/home/favorites.dart';
import 'package:dijital_kitap/screens/profile.dart';
import 'package:dijital_kitap/screens/settings.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get index => _selectedIndex;

  void toggleIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget get homeBody {
    switch (index) {
      case 0:
        return BooksGrid();
        break;
      case 1:
        return FavoritesGrid();
        break;
      case 2:
        return Profile();
        break;
      default:
        return Settings();
    }
  }
}
