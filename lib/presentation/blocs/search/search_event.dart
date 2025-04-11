import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  const SearchMoviesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
