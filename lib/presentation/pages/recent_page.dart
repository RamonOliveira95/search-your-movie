import 'package:flutter/material.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../widgets/state_widgets.dart';
import 'movie_details_page.dart';

class RecentPage extends StatefulWidget {
  final MovieRepositoryImpl repository;

  const RecentPage({super.key, required this.repository});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  late Future<List<Movie>> _futureMovies;

  @override
  void initState() {
    super.initState();
    _loadRecentMovies();
  }

  void _loadRecentMovies() {
    _futureMovies = widget.repository.getRecentMovies();
  }

  Future<void> _removeMovie(String imdbID) async {
    await widget.repository.removeRecentMovie(imdbID);
    setState(() {
      _loadRecentMovies();
    });
  }

  Future<void> _confirmDelete(Movie movie) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar remoção'),
        content: Text('Deseja remover "${movie.title}" da lista de recentes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _removeMovie(movie.imdbID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} removido dos recentes')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Recentes'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingStateWidget();
          } else if (snapshot.hasError) {
            return ErrorStateWidget(snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyStateWidget('Nenhum filme recente');
          }

          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(
                  movie.poster,
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.year),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDelete(movie),
                ),
                onTap: () async {
                  try {
                    final detailedMovie = await widget.repository.getMovieDetails(movie.imdbID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsPage(movie: detailedMovie),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao carregar detalhes: $e')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
