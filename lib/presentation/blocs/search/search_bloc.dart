import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import '../../../domain/cases/search_movies.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc(this.searchMovies) : super(SearchInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final movies = await searchMovies(event.query);
        emit(SearchSuccess(movies));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
