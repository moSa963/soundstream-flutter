import 'package:flutter/material.dart';
import 'package:soundstream_flutter/pages/home_page/home_page.dart';
import 'package:soundstream_flutter/pages/home_page/home_page_bottom_navigator.dart';
import 'package:soundstream_flutter/pages/library_page/library_page.dart';
import 'package:soundstream_flutter/pages/search_page/search_page.dart';

class HomeNavPage extends StatefulWidget {
  HomeNavPage({super.key});
  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const LibraryPage(),
  ];

  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[_index],
      bottomNavigationBar: HomePageBottomNavigator(
        index: _index,
        onChange: onIndexChange,
      ),
    );
  }

  void onIndexChange(int i) {
    if (_index == i) return;

    setState(() {
      _index = i;
    });
  }
}
