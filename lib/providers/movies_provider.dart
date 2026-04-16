import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/data/services/movies_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviesProvider with ChangeNotifier {
  final MoviesServices _movieServices = MoviesServices();
  List<Movie> _upComingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  Movie? _randomMovie;
  set randomMovie(Movie? value) {
    _randomMovie = value;
    notifyListeners();
  }

  bool _isLoading = true;

  List<Movie> get upComingMovies => _upComingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  Movie? get randomMovie => _randomMovie;
  bool get isLoading => _isLoading;
  MoviesProvider() {
    loadMovies();
  }
  void loadMovies() async {
    _upComingMovies = await _movieServices.getupComingMovies();
    _topRatedMovies = await _movieServices.getTopRatedMovies();
    _popularMovies = await _movieServices.getPopularMovies();
    _nowPlayingMovies = await _movieServices.getNowPlayingMovies();
    randomMovie = (topRatedMovies..shuffle()).first;
    _isLoading = false;
    notifyListeners();
  }

  String getFirstGenre({
    required Movie currentMovie,
    required int index,
    required List<Movie> moviesList,
  }) {
    if (currentMovie.genreIds.isEmpty) {
      return "N/A";
    }
    String foundGenre = genresList
        .toList()
        .firstWhere(
          (element) => element.id == moviesList[index].genreIds[0],
          orElse: () =>
              Genre(id: 0, name: "N/A", colors: [], icon: Icons.error),
        )
        .name;
    return foundGenre;
  }
}

