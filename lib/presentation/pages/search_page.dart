import 'package:flutter/material.dart';
import '../../../data/mock/mocked_movies.dart';
import '../pages/movie_details_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca de Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Digite o nome do filme',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Adicionar a busca ao app
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: MovieList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockedMovies.length,
      itemBuilder: (context, index) {
        final movie = mockedMovies[index];
        return ListTile(
          leading: Image.network(
            movie.poster,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(movie.title),
          subtitle: Text(movie.year),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsPage(movie: movie),
              ),
            );
          },
        );
      },
    );
  }
}
