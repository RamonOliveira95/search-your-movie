import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required String title,
    required String year,
    required String imdbID,
    required String poster,
    required String genre,
    required String plot,
  }) : super(
          title: title,
          year: year,
          imdbID: imdbID,
          poster: poster,
          genre: genre,
          plot: plot,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
  return MovieModel(
    title: json['Title'] ?? '',
    year: json['Year'] ?? '',
    imdbID: json['imdbID'] ?? '',
    poster: json['Poster'] ?? '',
    genre: json['Genre'] ?? '',
    plot: json['Plot'] ?? '',
  );
}

}
