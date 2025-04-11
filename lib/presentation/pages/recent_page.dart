import 'package:flutter/material.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/movie.dart';
import 'movie_details_page.dart';

class RecentPage extends StatelessWidget {
  final MovieRepositoryImpl repository;

  const RecentPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: repository.getRecentMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum filme recente'));
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
              onTap: () async {
                final detailedMovie = await repository.getMovieDetails(movie.imdbID);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailsPage(movie: detailedMovie),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
