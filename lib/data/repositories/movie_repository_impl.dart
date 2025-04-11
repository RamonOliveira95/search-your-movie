import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../sources/movie_remote_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  List<Movie> _recentMovies = [];

  @override
  Future<List<Movie>> searchMovies(String query, int page) {
    return datasource.searchMovies(query, page);
  }

  @override
  Future<Movie> getMovieDetails(String imdbID) {
    return datasource.getMovieDetails(imdbID);
  }

  @override
  Future<void> saveRecentMovie(Movie movie) async {
    _recentMovies.removeWhere((m) => m.imdbID == movie.imdbID);
    _recentMovies.insert(0, movie);
    if (_recentMovies.length > 5) {
      _recentMovies = _recentMovies.sublist(0, 5);
    }

    await _persistRecentMovies();
  }

  @override
  Future<List<Movie>> getRecentMovies() async {
    if (_recentMovies.isEmpty) {
      await _loadRecentMovies();
    }
    return _recentMovies;
  }

  Future<void> _persistRecentMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieJsonList =
        _recentMovies.map((movie) => jsonEncode(movie.toJson())).toList();
    await prefs.setStringList('recent_movies', movieJsonList);
  }

  Future<void> _loadRecentMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieJsonList = prefs.getStringList('recent_movies') ?? [];
    _recentMovies = movieJsonList
        .map((jsonMovie) => Movie.fromJson(jsonDecode(jsonMovie)))
        .toList();
  }

  Future<void> removeRecentMovie(String imdbID) async {
    _recentMovies.removeWhere((m) => m.imdbID == imdbID);
    await _persistRecentMovies();
  }
}
