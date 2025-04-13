import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_your_movie/domain/entities/movie.dart';
import 'package:search_your_movie/domain/cases/search_movies.dart';
import 'package:search_your_movie/domain/cases/save_recent_movie.dart';
import 'package:search_your_movie/presentation/blocs/search/search_bloc.dart';
import 'package:search_your_movie/presentation/blocs/search/search_event.dart';
import 'package:search_your_movie/presentation/blocs/search/search_state.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

class MockSaveRecentMovie extends Mock implements SaveRecentMovie {}

void main() {
  late SearchBloc bloc;
  late MockSearchMovies mockSearchMovies;
  late MockSaveRecentMovie mockSaveRecentMovie;

  final mockMovies = [
    Movie(
      title: 'The Matrix',
      year: '1999',
      imdbID: 'tt0133093',
      poster: 'https://example.com/matrix.jpg',
    ),
  ];

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSaveRecentMovie = MockSaveRecentMovie();
    bloc = SearchBloc(mockSearchMovies, mockSaveRecentMovie);
  });

  group('SearchBloc', () {
    blocTest<SearchBloc, SearchState>(
      'emite [SearchLoading, SearchSuccess] quando a busca retorna filmes com sucesso (primeira página)',
      build: () {
        when(() => mockSearchMovies('matrix', 1))
            .thenAnswer((_) async => mockMovies);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent('matrix', page: 1)),
      expect: () => [
        SearchLoading('matrix', 1),
        SearchSuccess(
          movies: mockMovies,
          query: 'matrix',
          currentPage: 1,
          hasMore: false,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emite [SearchLoading, SearchError] quando ocorre um erro na busca',
      build: () {
        when(() => mockSearchMovies('error', 1))
            .thenThrow(Exception('Falha de rede'));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchMoviesEvent('error', page: 1)),
      expect: () => [
        SearchLoading('error', 1),
        isA<SearchError>().having((e) => e.message, 'message',
            contains('Erro ao buscar filmes')),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'acumula filmes quando busca é paginada (página 2)',
      build: () {
        when(() => mockSearchMovies('matrix', 1))
            .thenAnswer((_) async => mockMovies);
        when(() => mockSearchMovies('matrix', 2))
            .thenAnswer((_) async => mockMovies);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(SearchMoviesEvent('matrix', page: 1));
        await Future.delayed(Duration.zero);
        bloc.add(SearchMoviesEvent('matrix', page: 2));
      },
      skip: 1,
      expect: () => [
        SearchSuccess(
          movies: mockMovies,
          query: 'matrix',
          currentPage: 1,
          hasMore: false,
        ),
        SearchSuccess(
          movies: [...mockMovies, ...mockMovies],
          query: 'matrix',
          currentPage: 2,
          hasMore: false,
        ),
      ],
    );
  });
}
