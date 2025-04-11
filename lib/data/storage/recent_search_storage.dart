import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/movie.dart';

class RecentSearchStorage {
  static const _key = 'recent_movies';

  Future<void> saveMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();

    // Carrega a lista atual
    final currentList = await getRecentMovies();

    // Remove duplicatas (Quando o imdbID é o mesmo já salvo)
    currentList.removeWhere((m) => m.imdbID == movie.imdbID);

    // Insere o novo no início
    currentList.insert(0, movie);

    // Mantém só os 5 primeiros
    final trimmedList = currentList.take(5).toList();

    // Converte para JSON
    final jsonList = trimmedList.map((m) => jsonEncode(m.toJson())).toList();

    // Salva
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<Movie>> getRecentMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList
        .map((jsonStr) => Movie.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
