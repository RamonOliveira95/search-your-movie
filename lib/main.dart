import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'data/sources/movie_remote_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/cases/search_movies.dart';
import 'domain/cases/save_recent_movie.dart';
import 'presentation/blocs/search/search_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'core/theme/theme.dart';

void main() {
  final dio = Dio();
  final datasource = MovieRemoteDatasourceImpl(dio: dio, apiKey: 'a48bc003');
  final repository = MovieRepositoryImpl(datasource);
  final searchMovies = SearchMovies(repository);
  final saveRecentMovie = SaveRecentMovie(repository);

  runApp(
    MyApp(
      searchMovies: searchMovies,
      saveRecentMovie: saveRecentMovie,
      remoteDatasource: datasource,
      repository: repository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SearchMovies searchMovies;
  final SaveRecentMovie saveRecentMovie;
  final MovieRemoteDatasourceImpl remoteDatasource;
  final MovieRepositoryImpl repository;

  const MyApp({
    super.key,
    required this.searchMovies,
    required this.saveRecentMovie,
    required this.remoteDatasource,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          home: BlocProvider(
            create: (_) => SearchBloc(searchMovies, saveRecentMovie),
            child: HomePage(
              remoteDatasource: remoteDatasource,
              repository: repository,
            ),
          ),
        );
      },
    );
  }
}
