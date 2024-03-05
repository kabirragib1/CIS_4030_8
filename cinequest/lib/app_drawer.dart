import 'package:cinequest/home_screen.dart';
import 'package:cinequest/logout_screen.dart';
import 'package:cinequest/saved_movies_screen.dart';
import 'package:cinequest/setting_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 3, 35, 90),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/drawerIcon.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          ListTile(
            title: Text('Homepage'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            leading: const Icon(Icons.home),
          ),
          ListTile(
            title: Text('Saved Movies'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SavedMoviesScreen()),
              );
            },
            leading: const Icon(Icons.favorite),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            leading: const Icon(Icons.settings),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogoutScreen()),
              );
            },
            leading: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}