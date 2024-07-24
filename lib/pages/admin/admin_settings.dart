import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF074173),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              subtitle: const Text('Edit your profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to profile edit page
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Manage notifications'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to notifications settings page
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security'),
              subtitle: const Text('Change your password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to security settings page
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              subtitle: const Text('Get help and support'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to help and support page
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform logout operation
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
