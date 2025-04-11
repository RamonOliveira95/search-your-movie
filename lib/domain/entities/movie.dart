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

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? json['Title'] ?? '',
      year: json['year'] ?? json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      poster: json['poster'] ?? json['Poster'] ?? '',
      genre: json['genre'] ?? json['Genre'],
      plot: json['plot'] ?? json['Plot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'imdbID': imdbID,
      'poster': poster,
      'genre': genre,
      'plot': plot,
    };
  }
}
