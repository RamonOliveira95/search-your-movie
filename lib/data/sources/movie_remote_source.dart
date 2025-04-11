import 'package:dio/dio.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final Dio dio;
  final String apiKey;

  MovieRemoteDatasourceImpl({required this.dio, required this.apiKey});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await dio.get(
      'http://www.omdbapi.com/',
      queryParameters: {
        'apikey': apiKey,
        's': query,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data['Response'] == 'True') {
        return (data['Search'] as List)
            .map((json) => MovieModel.fromJson(json))
            .toList();
      } else {
        throw Exception(data['Error'] ?? 'Erro desconhecido da API');
      }
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}
