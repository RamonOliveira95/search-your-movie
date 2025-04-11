import 'package:flutter/material.dart';
import 'search_page.dart';
import 'recent_page.dart';
import '../../data/sources/movie_remote_source.dart';
import '../../data/repositories/movie_repository_impl.dart';

class HomePage extends StatefulWidget {
  final MovieRemoteDatasourceImpl remoteDatasource;
  final MovieRepositoryImpl repository;

  const HomePage({
    super.key,
    required this.remoteDatasource,
    required this.repository,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SearchPage(
        repository: widget.repository,
      ),
      RecentPage(repository: widget.repository),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Recentes'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
