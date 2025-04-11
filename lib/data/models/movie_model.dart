import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  MovieModel({
    required String title,
    required String year,
    required String imdbID,
    required String type,
    required String poster,
  }) : super(
          title: title,
          year: year,
          imdbID: imdbID,
          type: type,
          poster: poster,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
