import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import 'movie_details_page.dart';
import '../../data/repositories/movie_repository_impl.dart';

class SearchPage extends StatefulWidget {
  final MovieRepositoryImpl repository;

  const SearchPage({
    super.key,
    required this.repository,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(SearchMoviesEvent(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Busca de Filmes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Digite o nome do filme',
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onSearch,
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(child: Text('Digite algo para buscar'));
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text('Nenhum filme encontrado'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieTile(
                          movie: movie,
                          repository: widget.repository,
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text('Erro: ${state.message}'));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;
  final MovieRepositoryImpl repository;

  const MovieTile({
    super.key,
    required this.movie,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
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
      onTap: () async {
        try {
          final detailedMovie = await repository.getMovieDetails(movie.imdbID);
          await repository.saveRecentMovie(detailedMovie);

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
  }
}
