import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import 'movie_details_page.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../widgets/state_widgets.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(SearchMoviesEvent(query, page: 1));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<SearchBloc>().state;
      if (state is SearchSuccess && state.hasMore) {
        context.read<SearchBloc>().add(SearchMoviesEvent(state.query, page: state.currentPage + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
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
                    decoration: const InputDecoration(labelText: 'Digite o nome do filme'),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _onSearch, child: const Text('Buscar')),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const EmptyStateWidget('Digite algo para buscar');
                  } else if (state is SearchLoading && state.page == 1) {
                    return const LoadingStateWidget();
                  } else if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return const EmptyStateWidget('Nenhum filme encontrado');
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasMore ? state.movies.length + 1 : state.movies.length,
                      itemBuilder: (context, index) {
                        if (index < state.movies.length) {
                          final movie = state.movies[index];
                          return MovieTile(movie: movie, repository: widget.repository);
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: LoadingStateWidget(),
                          );
                        }
                      },
                    );
                  } else if (state is SearchError) {
                    return ErrorStateWidget(state.message);
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
