import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart'; // Import the HomeScreen widget
import 'package:cinequest/sign_quiz.dart'; // Import the HomeScreen widget

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // This will keep the back arrow
        title: Text(''), // Empty title to hide the header
        backgroundColor: Colors.transparent, // Set background color to transparent
        elevation: 0, // Remove the shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/movie_4831192.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Sign Up To Unlock The Magic Of Cinema',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username Input
                  Text(
                    'ENTER USERNAME',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Username',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Email Input
                  Text(
                    'ENTER EMAIL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Password Input
                  Text(
                    'ENTER PASSWORD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  ),
                  SizedBox(height: 60),
                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Define what happens when the button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpQuiz()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                      ),
                      child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
