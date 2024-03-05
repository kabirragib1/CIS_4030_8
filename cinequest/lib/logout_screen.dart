import 'package:cinequest/app_drawer.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 80,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ), 
      body: Center(
        child: const Text(
          "Add Logout Screen UI",
          style: TextStyle(fontSize: 20),
        ),
      ),
       // drawer 
      drawer: AppDrawer(),
    );
  }
}
