import 'package:flutter/material.dart';
import 'package:cinequest/login.dart'; // Import the login page
import 'package:cinequest/sing_up.dart';

class SignInSignUpScreen extends StatelessWidget {
  const SignInSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Flexible(
              flex: 0,
              child: Image.asset(
                'assets/images/popcorn.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'WELCOME TO',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              'Unlock The Magic Of Cinema With CineQuest',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50),
              ),
              child: Text('SIGN IN', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50),
              ),
              child: Text('SIGN UP', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
