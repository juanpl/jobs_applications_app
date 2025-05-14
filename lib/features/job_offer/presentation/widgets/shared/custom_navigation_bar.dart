import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon (Icons.home_filled),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon:  Icon(Icons.list_alt_rounded),
          label: 'List'
        )
      ],
    );
  }
}