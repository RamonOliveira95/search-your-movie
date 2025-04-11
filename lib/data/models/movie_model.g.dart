// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  title: json['title'] as String,
  year: json['year'] as String,
  imdbID: json['imdbID'] as String,
  type: json['type'] as String,
  poster: json['poster'] as String,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'imdbID': instance.imdbID,
      'type': instance.type,
      'poster': instance.poster,
    };
