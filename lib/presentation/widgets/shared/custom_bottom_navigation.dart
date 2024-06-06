import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black45,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: "categorias"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favoritos"
        ),
      ]
    );
  }
}