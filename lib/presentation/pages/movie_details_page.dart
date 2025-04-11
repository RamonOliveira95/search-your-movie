import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(movie.poster, height: 250),
            const SizedBox(height: 20),
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Ano: ${movie.year}'),
            const SizedBox(height: 8),
            Text('Tipo: ${movie.type}'),
            const SizedBox(height: 16),
            const Text(
              'Sinopse (mock): Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
