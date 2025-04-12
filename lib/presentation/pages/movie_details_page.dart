import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../core/theme/theme.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.poster,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              height: 200,
                              color: theme.colorScheme.surfaceVariant,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text('Ano: ${movie.year}'),
                          backgroundColor: theme.colorScheme.primaryContainer,
                        ),
                        if (movie.genre != null)
                          Chip(
                            label: Text('Gênero: ${movie.genre}'),
                            backgroundColor: theme.colorScheme.primaryContainer,
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Sinopse',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.plot ?? 'Sem sinopse disponível',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
