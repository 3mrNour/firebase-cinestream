import 'dart:convert';
import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<Movie> _favorites = [];
  bool _isLoading = true;

  List<Movie> get favorites => _favorites;
  bool get isLoading => _isLoading;

  FavoriteProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favStrings = prefs.getStringList('favorite_movies');

    if (favStrings != null) {
      _favorites = favStrings.map((movieStr) {
        return Movie.fromJson(json.decode(movieStr));
      }).toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Movie movie) async {
    final existingIndex = _favorites.indexWhere((m) => m.id == movie.id);

    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(movie);
    }

    notifyListeners();
    await _saveFavorites();
    if (kDebugMode) {
      print("Favorites Updated: ${_favorites}");
    }
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favStrings = _favorites.map((m) {
      return json.encode(m.toJson());
    }).toList();

    await prefs.setStringList('favorite_movies', favStrings);
  }

  bool isFavorite(int movieId) {
    return _favorites.any((m) => m.id == movieId);
  }

  String getGenreName(int id) {
    return genresList
        .firstWhere(
          (element) => element.id == id,
          orElse: () =>
              Genre(id: 0, name: "N/A", colors: [], icon: Icons.error),
        )
        .name;
  }
}
