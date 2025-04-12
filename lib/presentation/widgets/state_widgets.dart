import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String message;

  const ErrorStateWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Erro: $message',
        style: TextStyle(color: theme.colorScheme.onSurface),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        message,
        style: TextStyle(color: theme.colorScheme.onSurface),
        textAlign: TextAlign.center,
      ),
    );
  }
}
