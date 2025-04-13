import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/presentation/blocs/search/search_event.dart';

void main() {
  group('SearchMoviesEvent', () {
    test('deve conter os valores corretos', () {
      const query = 'batman';
      const page = 2;

      final event = SearchMoviesEvent(query, page: page);

      expect(event.query, query);
      expect(event.page, page);
    });

    test('dois eventos com mesmos valores não são iguais (sem Equatable)', () {
      final event1 = SearchMoviesEvent('matrix', page: 1);
      final event2 = SearchMoviesEvent('matrix', page: 1);

      expect(event1 == event2, isFalse);
    });
  });
}
