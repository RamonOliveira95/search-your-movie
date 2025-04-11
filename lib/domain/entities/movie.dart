class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String poster;
  final String? genre;
  final String? plot;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
    this.genre,
    this.plot,
  });
}
