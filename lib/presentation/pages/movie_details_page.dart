import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                movie.poster,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text('Ano: ${movie.year}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Gênero: ${movie.genre ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Sinopse:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(movie.plot ?? 'Sem sinopse disponível', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
