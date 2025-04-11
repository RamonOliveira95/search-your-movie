import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../sources/movie_remote_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await remoteDatasource.searchMovies(query);
  }
}
