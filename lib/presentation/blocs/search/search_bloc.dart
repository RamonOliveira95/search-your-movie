import 'package:flutter_bloc/flutter_bloc.dart';
import 'search.dart';
import '../../../domain/cases/cases.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  final SaveRecentMovie saveRecentMovie;

  SearchBloc(this.searchMovies, this.saveRecentMovie) : super(SearchInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      final currentState = state;
      final isFirstPage = event.page == 1;

      if (isFirstPage) {
        emit(SearchLoading(event.query, event.page));
      }

      try {
        final newMovies = await searchMovies(event.query, event.page);
        final hasMore = newMovies.length >= 10;

        if (currentState is SearchSuccess && !isFirstPage) {
          emit(SearchSuccess(
            movies: [...currentState.movies, ...newMovies],
            query: event.query,
            currentPage: event.page,
            hasMore: hasMore,
          ));
        } else {
          emit(SearchSuccess(
            movies: newMovies,
            query: event.query,
            currentPage: event.page,
            hasMore: hasMore,
          ));
        }
      } catch (e) {
        emit(SearchError('Erro ao buscar filmes: $e'));
      }
    });
  }
}
