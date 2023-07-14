import 'package:flutter/material.dart';

class HomePageBottomNavigator extends StatelessWidget {
  final int index;
  final void Function(int index) onChange;

  const HomePageBottomNavigator(
      {super.key, required this.index, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.background, Colors.transparent ],
          begin: AlignmentDirectional.bottomCenter,
          end: Alignment.topCenter,
          
        ),
      ),
    
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: onChange,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Library",
          ),
        ],
      ),
    );
  }
}
