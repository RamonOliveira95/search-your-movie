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

  const SearchPage({super.key, required this.repository});

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
    if (query.isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Atenção'),
              content: const Text('Por favor, adicione um filme para buscar'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'),
                ),
              ],
            ),
      );
    } else {
      context.read<SearchBloc>().add(SearchMoviesEvent(query, page: 1));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<SearchBloc>().state;
      if (state is SearchSuccess && state.hasMore) {
        context.read<SearchBloc>().add(
          SearchMoviesEvent(state.query, page: state.currentPage + 1),
        );
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Digite o nome do filme',
                      labelStyle: TextStyle(color: theme.hintColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(color: theme.hintColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
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
                    return const EmptyStateWidget('Digite algo para buscar');
                  } else if (state is SearchLoading && state.page == 1) {
                    return const LoadingStateWidget();
                  } else if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return const EmptyStateWidget('Nenhum filme encontrado');
                    }

                    // Verificar se há mais filmes para carregar e exibir o carregamento condicionalmente
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.hasMore
                              ? state.movies.length + 1
                              : state.movies.length,
                      itemBuilder: (context, index) {
                        if (index < state.movies.length) {
                          final movie = state.movies[index];
                          return MovieCard(
                            movie: movie,
                            repository: widget.repository,
                          );
                        } else {
                          return state.hasMore
                              ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: LoadingStateWidget(),
                              )
                              : const SizedBox.shrink();
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

class MovieCard extends StatelessWidget {
  final Movie movie;
  final MovieRepositoryImpl repository;

  const MovieCard({super.key, required this.movie, required this.repository});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.poster,
            width: 50,
            height: 75,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          movie.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(movie.year, style: theme.textTheme.bodySmall),
        onTap: () async {
          final currentContext = context;
          try {
            final detailedMovie = await repository.getMovieDetails(
              movie.imdbID,
            );
            await repository.saveRecentMovie(detailedMovie);
            if (!currentContext.mounted) return;
            Navigator.push(
              currentContext,
              MaterialPageRoute(
                builder: (_) => MovieDetailsPage(movie: detailedMovie),
              ),
            );
          } catch (e) {
            if (!currentContext.mounted) return;
            ScaffoldMessenger.of(currentContext).showSnackBar(
              SnackBar(content: Text('Erro ao carregar detalhes: $e')),
            );
          }
        },
      ),
    );
  }
}
