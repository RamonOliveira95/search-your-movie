import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  final String query;
  final int page;

  const SearchLoading(this.query, this.page);

  @override
  List<Object> get props => [query, page];
}

class SearchSuccess extends SearchState {
  final List<Movie> movies;
  final String query;
  final int currentPage;
  final bool hasMore;

  const SearchSuccess({
    required this.movies,
    required this.query,
    required this.currentPage,
    required this.hasMore,
  });

  @override
  List<Object> get props => [movies, query, currentPage, hasMore];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
