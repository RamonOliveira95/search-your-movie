abstract class SearchEvent {}

class SearchMoviesEvent extends SearchEvent {
  final String query;
  final int page;

  SearchMoviesEvent(this.query, {this.page = 1});
}
