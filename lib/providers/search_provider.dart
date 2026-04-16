import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/data/services/movies_services.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final MoviesServices _services = MoviesServices();
  String _searchQuery = "";
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  bool _isSearchMode = false;
  bool _isGenreMode = false; 
  String _currentGenreQuery = ""; 

  bool get isGenreMode => _isGenreMode;

  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearchMode => _isSearchMode;
  String get currentQuery => _searchQuery;
String get currentGenreQuery => _currentGenreQuery;
  Future<void> submitSearch(String query) async {
    _isSearchMode = true;
    _isLoading = true;
    _isGenreMode = false;
    notifyListeners();
    _searchResults = await _services.searchMovies(query);
    _isLoading = false;
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _isSearchMode = false;
    _isGenreMode = false;
    _currentGenreQuery = "";
    _searchResults = [];
    notifyListeners();
  }



  Future<void> searchByGenre(int genreId, String genreName) async {
    _isSearchMode = true;
    _isGenreMode = true;
    _currentGenreQuery = "$genreName Movies";
    _isLoading = true;
    notifyListeners();
    _searchResults = await _services.getMoviesByGenre(genreId);
    _isLoading = false;
    notifyListeners();
  }

}
