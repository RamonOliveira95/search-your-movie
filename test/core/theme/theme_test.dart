import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search_your_movie/core/theme/theme.dart';

void main() {
  group('Theme Tests', () {
    test('Deve aplicar o dark theme corretamente', () {
      final ThemeData dark = darkTheme;

      expect(dark.brightness, Brightness.dark);
      expect(dark.scaffoldBackgroundColor, const Color(0xFF121212));
      expect(dark.appBarTheme.backgroundColor, Colors.black);
      expect(dark.appBarTheme.foregroundColor, Colors.white);
      expect(dark.bottomNavigationBarTheme.backgroundColor, Colors.black);
      expect(dark.bottomNavigationBarTheme.selectedItemColor, Colors.amber);
      expect(dark.bottomNavigationBarTheme.unselectedItemColor, Colors.white54);
    });

    test('Deve aplicar o light theme corretamente', () {
      final ThemeData light = lightTheme;

      expect(light.brightness, Brightness.light);
      expect(light.scaffoldBackgroundColor, Colors.white);
      expect(light.appBarTheme.backgroundColor, Colors.amber);
      expect(light.appBarTheme.foregroundColor, Colors.black);
      expect(light.bottomNavigationBarTheme.backgroundColor, Colors.white);
      expect(light.bottomNavigationBarTheme.selectedItemColor, Colors.amber);
      expect(light.bottomNavigationBarTheme.unselectedItemColor, Colors.black54);
    });

    test('O themeNotifier começa com o tema escuro', () {
      expect(themeNotifier.value, ThemeMode.dark);
    });

    test('O themeNotifier pode alternar para o tema claro', () {
      themeNotifier.value = ThemeMode.light;
      expect(themeNotifier.value, ThemeMode.light);
    });
  });
}
