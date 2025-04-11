import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies(String query, int page);
  Future<Movie> getMovieDetails(String imdbID);
  Future<void> saveRecentMovie(Movie movie);
  Future<List<Movie>> getRecentMovies();
}
