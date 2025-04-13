import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search_your_movie/domain/entities/movie.dart';
import 'package:search_your_movie/domain/repositories/movie_repository.dart';
import 'package:search_your_movie/domain/cases/search_movies.dart';

@GenerateMocks([MovieRepository])
import 'search_movies_test.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = SearchMovies(mockRepository);
  });

  test('deve retornar uma lista de filmes ao buscar pelo termo', () async {
    const query = 'matrix';
    const page = 1;

    final movies = [
      Movie(
        title: 'The Batman',
        year: '2022',
        imdbID: 'tt1877830',
        poster: 'https://...',
      ),
    ];

    when(
      mockRepository.searchMovies(query, page),
    ).thenAnswer((_) async => movies);

    final result = await usecase(query, page);

    expect(result, movies);
    verify(mockRepository.searchMovies(query, page)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
