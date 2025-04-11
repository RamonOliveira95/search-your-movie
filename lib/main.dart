import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'data/sources/movie_remote_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/cases/search_movies.dart';
import 'presentation/blocs/search/search_bloc.dart';
import 'presentation/pages/search_page.dart';

void main() {
  final dio = Dio();
  final datasource = MovieRemoteDatasourceImpl(dio: dio, apiKey: 'a48bc003');
  final repository = MovieRepositoryImpl(datasource);
  final searchMovies = SearchMovies(repository);

  runApp(
    MyApp(
      searchMovies: searchMovies,
      remoteDatasource: datasource,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SearchMovies searchMovies;
  final MovieRemoteDatasource remoteDatasource;

  const MyApp({
    super.key,
    required this.searchMovies,
    required this.remoteDatasource,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => SearchBloc(searchMovies),
        child: SearchPage(remoteDatasource: remoteDatasource),
      ),
    );
  }
}

