import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import '../../../domain/cases/search_movies.dart';
import '../../../domain/cases/save_recent_movie.dart';

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
        final hasMore = newMovies.isNotEmpty;

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
