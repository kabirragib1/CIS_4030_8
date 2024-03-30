import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart';
import 'package:cinequest/mongodb.dart'; // Ensure this import points to your MongoDB utility class
import 'package:cinequest/sign_quiz.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('ENTER USERNAME', _usernameController),
                  SizedBox(height: 20),
                  _buildTextField('ENTER EMAIL', _emailController),
                  SizedBox(height: 20),
                  _buildTextField('ENTER PASSWORD', _passwordController, isPassword: true),
                  SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitSignUpForm(context),
                      style: ElevatedButton.styleFrom(minimumSize: Size(300, 50)),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
        ),
      ],
    );
  }

  void _submitSignUpForm(BuildContext context) async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    bool usernameExists = await MongoDatabase.checkUserExistsByUsername(username);
    bool emailExists = await MongoDatabase.checkUserExistsByEmail(email);

    if (usernameExists) {
      _showAlertDialog(context, 'Username is already taken. Please try another one.');
      return;
    }

    if (emailExists) {
      _showAlertDialog(context, 'Email is already registered. Please use a different email.');
      return;
    }

    // Proceed with inserting the new user if username and email are unique
    await MongoDatabase.insertUser({
      'username': username,
      'email': email,
      'password': password, // Consider hashing this password
    });

    // Navigate to the next screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpQuiz()));
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
