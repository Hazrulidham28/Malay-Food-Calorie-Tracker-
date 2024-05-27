import 'package:flutter/material.dart';
import 'profile_page.dart';
import '../widgets/main_page_widgets.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Index of the selected bottom navigation bar item

  // Define list of pages directly in the HomePage class
  final List<Widget> _pages = [
    MainPageWidgets(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        alignment: Alignment.center,
        child: Text(
          'Malay Food Calorie Tracker',
          textAlign: TextAlign.right,
        ),
      ),
      // Add something to the appBar if needed
    );

    return Scaffold(
      // appBar: appBar,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_2user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
