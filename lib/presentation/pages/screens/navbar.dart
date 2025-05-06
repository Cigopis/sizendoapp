import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class Navbar extends StatefulWidget {
  final String userEmail;
  const Navbar({super.key, required this.userEmail});

  @override
  State<Navbar> createState() => _NavbarState();
}

  class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
    const HomeScreen(),
    const SearchScreen(),
    ProfileScreen(userEmail: widget.userEmail), // kirim email ke Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
