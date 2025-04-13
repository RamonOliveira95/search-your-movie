import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/presentation/widgets/state_widgets.dart';

void main() {
  testWidgets('Deve exibir o indicador de carregamento', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: LoadingStateWidget()),
      ));
      
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Deve exibir a mensagem de erro', (WidgetTester tester) async {
    const errorMessage = 'Erro ao carregar os dados!';
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ErrorStateWidget(errorMessage)),
      ));
      
    expect(find.text('Erro: $errorMessage'), findsOneWidget);
  });

  testWidgets('Deve exibir a mensagem quando não houver dados', (WidgetTester tester) async {
    const emptyMessage = 'Nenhum dado disponível';
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: EmptyStateWidget(emptyMessage)),
      ));
      
    expect(find.text(emptyMessage), findsOneWidget);
  });
}
