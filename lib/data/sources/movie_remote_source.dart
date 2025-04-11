import 'package:dio/dio.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<Movie>> searchMovies(String query);

  getMovieDetails(String imdbID) {}
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final Dio dio;
  final String apiKey;

  MovieRemoteDatasourceImpl({required this.dio, required this.apiKey});

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await dio.get(
      'http://www.omdbapi.com/',
      queryParameters: {'apikey': apiKey, 's': query},
    );

    if (response.statusCode == 200) {
      final data = response.data;

      if (data['Response'] == 'True') {
        final List results = data['Search'];
        return results.map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw Exception(data['Error'] ?? 'Nenhum filme encontrado');
      }
    } else {
      throw Exception('Erro na conexão com a API');
    }
  }

  @override
  Future<Movie> getMovieDetails(String imdbID) async {
    final response = await dio.get(
      'http://www.omdbapi.com/',
      queryParameters: {'apikey': apiKey, 'i': imdbID},
    );

    if (response.statusCode == 200) {
      final data = response.data;

      if (data['Response'] == 'True') {
        return MovieModel.fromJson(data);
      } else {
        throw Exception(data['Error'] ?? 'Filme não encontrado');
      }
    } else {
      throw Exception('Erro ao buscar detalhes do filme');
    }
  }
}
