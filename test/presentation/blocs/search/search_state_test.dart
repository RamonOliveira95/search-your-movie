import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/domain/entities/movie.dart';
import 'package:search_your_movie/presentation/blocs/search/search_state.dart';

void main() {
  group('SearchState', () {
    test('SearchInitial props deve ser vazio', () {
      expect(const SearchInitial().props, []);
    });

    test('SearchLoading deve comparar corretamente', () {
      const state1 = SearchLoading('batman', 1);
      const state2 = SearchLoading('batman', 1);
      const state3 = SearchLoading('superman', 2);

      expect(state1, equals(state2));
      expect(state1 == state3, isFalse);
    });

    test('SearchSuccess deve comparar corretamente', () {
      final movie = Movie(
        title: 'Test Movie',
        year: '2023',
        imdbID: 'tt1234567',
        poster: 'url',
        genre: 'Action',
        plot: 'Some plot',
      );

      final state1 = SearchSuccess(
        movies: [movie],
        query: 'test',
        currentPage: 1,
        hasMore: true,
      );

      final state2 = SearchSuccess(
        movies: [movie],
        query: 'test',
        currentPage: 1,
        hasMore: true,
      );

      final state3 = SearchSuccess(
        movies: [],
        query: 'test',
        currentPage: 1,
        hasMore: true,
      );

      expect(state1, equals(state2));
      expect(state1 == state3, isFalse);
    });

    test('SearchError deve comparar corretamente', () {
      const state1 = SearchError('Erro');
      const state2 = SearchError('Erro');
      const state3 = SearchError('Outro erro');

      expect(state1, equals(state2));
      expect(state1 == state3, isFalse);
    });
  });
}
