import 'package:cinestream/data/models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoviesServices {
  final CollectionReference<Map<String, dynamic>> _moviesCollection =
      FirebaseFirestore.instance.collection('movies');

  Future<List<Movie>> _getAllMovies() async {
    final querySnapshot = await _moviesCollection.get();
    return querySnapshot.docs
        .map((doc) => Movie.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<List<Movie>> getupComingMovies() async {
    try {
      return _getAllMovies();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      return _getAllMovies();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      return _getAllMovies();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      return _getAllMovies();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getRelatedMovies(Movie movie) async {
    try {
      final all = await _getAllMovies();
      return all.where((m) => m.id != movie.id).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final all = await _getAllMovies();
      final searchText = query.trim().toLowerCase();
      if (searchText.isEmpty) return all;
      return all
          .where(
            (m) =>
                m.title.toLowerCase().contains(searchText) ||
                m.originalTitle.toLowerCase().contains(searchText) ||
                m.overview.toLowerCase().contains(searchText),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getMoviesByGenre(int genreId) async {
    try {
      final all = await _getAllMovies();
      return all.where((m) => m.genreIds.contains(genreId)).toList();
    } catch (_) {
      return [];
    }
  }
}
