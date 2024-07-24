import 'package:flutter/material.dart';
import 'package:na9ex_app/pages/admin/admin_home.dart';
import 'package:na9ex_app/pages/admin/create_ticket.dart';
import '../pages/admin/admin_settings.dart';

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
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.amber,
        backgroundColor: const Color(0xFF074173),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
      ),
      child: NavigationBar(
        onDestinationSelected: (int index) {
          onDestinationSelected(index);
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminHomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TicketForm()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
              break;
          }
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.article, color: Colors.white),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Colors.white),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
