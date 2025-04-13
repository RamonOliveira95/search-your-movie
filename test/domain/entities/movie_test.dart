import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/domain/entities/movie.dart';

void main() {
  group('Movie Entity', () {
    final movie = Movie(
      title: 'The Matrix',
      year: '1999',
      imdbID: 'tt0133093',
      poster: 'https://example.com/matrix.jpg',
      genre: 'Action, Sci-Fi',
      plot: 'A computer hacker learns about the true nature of reality.',
    );

    final jsonMap = {
      'title': 'The Matrix',
      'year': '1999',
      'imdbID': 'tt0133093',
      'poster': 'https://example.com/matrix.jpg',
      'genre': 'Action, Sci-Fi',
      'plot': 'A computer hacker learns about the true nature of reality.',
    };

    test('toJson deve retornar um mapa JSON válido', () {
      expect(movie.toJson(), equals(jsonMap));
    });

    test('fromJson deve criar uma instância válida de Movie', () {
      final result = Movie.fromJson(jsonMap);
      expect(result.title, movie.title);
      expect(result.year, movie.year);
      expect(result.imdbID, movie.imdbID);
      expect(result.poster, movie.poster);
      expect(result.genre, movie.genre);
      expect(result.plot, movie.plot);
    });

    test('fromJson deve lidar com chaves alternativas (Title, Year, Poster, Genre, Plot)', () {
      final altJson = {
        'Title': 'The Matrix',
        'Year': '1999',
        'imdbID': 'tt0133093',
        'Poster': 'https://example.com/matrix.jpg',
        'Genre': 'Action, Sci-Fi',
        'Plot': 'A computer hacker learns about the true nature of reality.',
      };

      final result = Movie.fromJson(altJson);
      expect(result.title, movie.title);
      expect(result.year, movie.year);
      expect(result.poster, movie.poster);
      expect(result.genre, movie.genre);
      expect(result.plot, movie.plot);
    });

    test('fromJson deve definir strings vazias para campos ausentes obrigatórios', () {
      final partialJson = {
        'imdbID': 'tt0133093',
      };

      final result = Movie.fromJson(partialJson);
      expect(result.title, '');
      expect(result.year, '');
      expect(result.poster, '');
      expect(result.imdbID, 'tt0133093');
      expect(result.genre, isNull);
      expect(result.plot, isNull);
    });
  });
}
