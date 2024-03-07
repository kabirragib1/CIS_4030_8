import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart'; 
import 'forgot_password_screen.dart'; 

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // This will keep the back arrow
        title: Text(''), // Empty title to hide the header
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Add some space at the top
            Center(
              child: Image.asset(
                'assets/images/popcorn.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Sign In To Unlock The Magic Of Cinema',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'EMAIL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'PASSWORD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    obscureText: true, // This will hide the entered text
                    decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 60), // Add some space above the button
                Center( // Align the button in the middle horizontally
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home page instead of login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                    ),
                    child: Text('LOGIN', style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 10), // Add some space between login button and forgot password
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to forgot password page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline, // Underline the text
                        color: Colors.white, // Set hyperlink color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
