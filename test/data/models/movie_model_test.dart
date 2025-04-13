import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/data/models/movie_model.dart';

void main() {
  group('MovieModel', () {
    test('Deve criar um MovieModel a partir de um JSON válido', () {
      // Um exemplo de JSON
      final Map<String, dynamic> json = {
        'Title': 'Movie Title',
        'Year': '2025',
        'imdbID': 'tt1234567',
        'Poster': 'https://example.com/poster.jpg',
        'Genre': 'Action',
        'Plot': 'A great movie plot.',
      };

      final movie = MovieModel.fromJson(json);

      expect(movie.title, 'Movie Title');
      expect(movie.year, '2025');
      expect(movie.imdbID, 'tt1234567');
      expect(movie.poster, 'https://example.com/poster.jpg');
      expect(movie.genre, 'Action');
      expect(movie.plot, 'A great movie plot.');
    });

    test('Deve retornar MovieModel com valores vazios se o JSON for incompleto', () {
      // Um exemplo de JSON incompleto
      final Map<String, dynamic> json = {
        'Title': 'Movie Title',
        'Year': '2025',
        'Poster': 'https://example.com/poster.jpg',
        'Plot': 'A great movie plot.',
      };

      // Criação do MovieModel com valores faltando no JSON
      final movie = MovieModel.fromJson(json);

      expect(movie.title, 'Movie Title');
      expect(movie.year, '2025');
      expect(movie.imdbID, '');
      expect(movie.poster, 'https://example.com/poster.jpg');
      expect(movie.genre, '');
      expect(movie.plot, 'A great movie plot.');
    });
  });
}
