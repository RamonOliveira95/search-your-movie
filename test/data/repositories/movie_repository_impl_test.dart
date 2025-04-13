import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:search_your_movie/data/repositories/movie_repository_impl.dart';
import 'package:search_your_movie/data/sources/movie_remote_source.dart';
import 'package:search_your_movie/domain/entities/movie.dart';

class MockMovieRemoteDatasource extends Mock implements MovieRemoteDatasource {}

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDatasource mockDatasource;

  final movie = Movie(
    title: 'The Matrix',
    year: '1999',
    imdbID: 'tt0133093',
    poster: 'https://poster.url',
    genre: 'Action',
    plot: 'A hacker discovers reality is a simulation.',
  );

  setUp(() {
    mockDatasource = MockMovieRemoteDatasource();
    repository = MovieRepositoryImpl(mockDatasource);
    SharedPreferences.setMockInitialValues({});
  });

  group('MovieRepositoryImpl', () {
    test('searchMovies deve delegar corretamente para o datasource', () async {
      when(() => mockDatasource.searchMovies('matrix', 1))
          .thenAnswer((_) async => [movie]);

      final result = await repository.searchMovies('matrix', 1);

      expect(result, [movie]);
      verify(() => mockDatasource.searchMovies('matrix', 1)).called(1);
    });

    test('getMovieDetails deve delegar corretamente para o datasource', () async {
      when(() => mockDatasource.getMovieDetails('tt0133093'))
          .thenAnswer((_) async => movie);

      final result = await repository.getMovieDetails('tt0133093');

      expect(result, movie);
      verify(() => mockDatasource.getMovieDetails('tt0133093')).called(1);
    });

    test('saveRecentMovie deve adicionar o filme corretamente e persistir', () async {
      await repository.saveRecentMovie(movie);

      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('recent_movies');

      expect(saved, isNotNull);
      expect(saved!.length, 1);
      expect(jsonDecode(saved[0])['imdbID'], movie.imdbID);
    });

    test('getRecentMovies deve carregar filmes salvos no SharedPreferences', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recent_movies', [
        jsonEncode(movie.toJson())
      ]);

      final result = await repository.getRecentMovies();

      expect(result.length, 1);
      expect(result.first.imdbID, movie.imdbID);
    });

    test('removeRecentMovie deve remover corretamente e persistir', () async {
      await repository.saveRecentMovie(movie);
      await repository.removeRecentMovie(movie.imdbID);

      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('recent_movies');

      expect(saved, isEmpty);
    });
  });
}
