import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/cupertino.dart';

class NavProvider with ChangeNotifier {
  int _selectedIndex = 0;
  Movie? _selectedMovie;
  int get selectedIndex => _selectedIndex;
  Movie? get selectedMovie => _selectedMovie;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void goToMovieScreen(Movie movie) {
    _selectedMovie = movie;
    _selectedIndex = 1;
    notifyListeners();
  }
}
