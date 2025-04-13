import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_your_movie/domain/cases/save_recent_movie.dart';
import 'package:search_your_movie/domain/entities/movie.dart';
import 'package:search_your_movie/data/repositories/movie_repository_impl.dart';

class MockMovieRepositoryImpl extends Mock implements MovieRepositoryImpl {}

void main() {
  group('SaveRecentMovie', () {
    late MockMovieRepositoryImpl mockRepository;
    late SaveRecentMovie saveRecentMovie;

    setUp(() {
      mockRepository = MockMovieRepositoryImpl();
      saveRecentMovie = SaveRecentMovie(mockRepository);
    });

    test('Deve chamar saveRecentMovie no repositório com o filme', () async {
      final movie = Movie(
        title: 'Inception',
        year: '2010',
        imdbID: 'tt1375666',
        poster: 'https://example.com/inception.jpg',
        genre: 'Sci-Fi',
        plot: 'A mind-bending thriller.',
      );

      when(() => mockRepository.saveRecentMovie(movie)).thenAnswer((_) async {});

      await saveRecentMovie(movie);

      verify(() => mockRepository.saveRecentMovie(movie)).called(1);
    });
  });
}
