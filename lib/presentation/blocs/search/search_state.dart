import '../../../domain/entities/movie.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final String query;
  final int page;

  SearchLoading(this.query, this.page);
}

class SearchSuccess extends SearchState {
  final List<Movie> movies;
  final String query;
  final int currentPage;
  final bool hasMore;

  SearchSuccess({
    required this.movies,
    required this.query,
    required this.currentPage,
    required this.hasMore,
  });
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
