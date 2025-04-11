import '../entities/movie.dart';
import '../../data/repositories/movie_repository_impl.dart';

class SaveRecentMovie {
  final MovieRepositoryImpl repository;

  SaveRecentMovie(this.repository);

  Future<void> call(Movie movie) {
    return repository.saveRecentMovie(movie);
  }
}
