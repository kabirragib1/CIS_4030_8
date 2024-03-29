import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart';
import 'package:cinequest/mongodb.dart'; // Make sure to import your MongoDB database utility class
import 'package:cinequest/sign_quiz.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Create a text editing controller for each form field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    controller: _usernameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                      onPressed: () async {
                        // Here, you'll capture the user input from the controllers
                        final String username = _usernameController.text;
                        final String email = _emailController.text;
                        final String password = _passwordController.text; // Consider hashing this password

                        // You can now use these values to insert the user into your MongoDB database
                        // For example:
                        await MongoDatabase.insertUser({
                          'username': username,
                          'email': email,
                          'password': password, // Make sure to hash the password before storing it
                        });

                        // After inserting the user, navigate to the next screen
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
