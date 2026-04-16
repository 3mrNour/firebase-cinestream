import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/data/services/movies_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedMovieProvider with ChangeNotifier {
  final MoviesServices _movieServices = MoviesServices();
  List<Movie> _relatedMovies = [];
  bool _isLoadingRelated = true;
  bool _isLoading = true;

  List<Movie> get relatedMovies => _relatedMovies;

  bool get isLoading => _isLoading;
  bool get isLoadingRelated => _isLoadingRelated;
  SelectedMovieProvider(Movie selectedMovie) {
    loadMovies(selectedMovie);
  }
  void loadMovies(Movie selectedMovie) async {
    _relatedMovies = await _movieServices.getRelatedMovies(selectedMovie);
    _isLoading = false;
    _isLoadingRelated = false;
    notifyListeners();
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
