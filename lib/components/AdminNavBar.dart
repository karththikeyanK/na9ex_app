// admin_nav.dart
import 'package:flutter/material.dart';

class AdminNavBar extends StatelessWidget {
  final int currentPageIndex;
  final Function(int) onDestinationSelected;

  const AdminNavBar({
    required this.currentPageIndex,
    required this.onDestinationSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Colors.amber,
      backgroundColor: const Color(0xFF074173),
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home,color:Colors.white,),
          icon: Icon(Icons.home_outlined,color:Colors.white),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.notifications_sharp,color:Colors.white)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp,color:Colors.white),
          ),
          label: 'Messages',
        ),
      ],
    );
  }
}