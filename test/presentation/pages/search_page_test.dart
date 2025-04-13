import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_your_movie/presentation/pages/search_page.dart';
import 'package:search_your_movie/presentation/blocs/search/search_bloc.dart';
import 'package:search_your_movie/presentation/blocs/search/search_state.dart';
import 'package:search_your_movie/presentation/blocs/search/search_event.dart';
import 'package:search_your_movie/data/repositories/movie_repository_impl.dart';
import 'package:search_your_movie/data/sources/movie_remote_source.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSearchBloc extends Mock implements SearchBloc {}
class FakeSearchState extends Fake implements SearchState {}
class FakeSearchEvent extends Fake implements SearchEvent {}
class MockMovieRemoteDatasource extends Mock implements MovieRemoteDatasource {}

void main() {
  late MockSearchBloc mockBloc;
  late MockMovieRemoteDatasource mockDatasource;

  setUpAll(() {
    registerFallbackValue(FakeSearchState());
    registerFallbackValue(FakeSearchEvent());
  });

  setUp(() {
    mockBloc = MockSearchBloc();
    mockDatasource = MockMovieRemoteDatasource();
  });

  Widget createTestableWidget() {
    final repository = MovieRepositoryImpl(mockDatasource);

    return MaterialApp(
      home: BlocProvider<SearchBloc>.value(
        value: mockBloc,
        child: SearchPage(repository: repository),
      ),
    );
  }

  testWidgets('Exibe estado inicial com texto de instrução',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchInitial());
    whenListen(mockBloc, Stream<SearchState>.fromIterable([SearchInitial()]));

    await tester.pumpWidget(createTestableWidget());
    expect(find.text('Digite algo para buscar'), findsOneWidget);
  });
}
