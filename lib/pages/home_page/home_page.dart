import 'package:flutter/material.dart';
import 'package:soundstream_flutter/pages/home_page/home_page_bottom_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: HomePageBottomNavigator(
        index: _index,
        onChange: (i) => setState(() {
          _index = i;
        }),
      ),
    );
  }
}
