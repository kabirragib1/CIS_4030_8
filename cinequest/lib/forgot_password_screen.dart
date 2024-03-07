import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart'; 

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Keep the back arrow
        elevation: 0, // Remove the shadow
        backgroundColor: Colors.transparent, 
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar to cover the app bar
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0), // Adjusted top padding for image
              child: Image.asset(
                'assets/images/popcorn.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20), // Add space above the text
                  Text(
                    'Recover Your Password',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ENTER YOUR EMAIL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Enter Passcode screen after submitting email
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EnterPasscodeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                    ),
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
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

class EnterPasscodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Keep the back arrow
        elevation: 0, // Remove the shadow
        backgroundColor: Colors.transparent, 
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar to cover the app bar
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0), // Adjusted top padding for image
              child: Image.asset(
                'assets/images/popcorn.png', 
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20), // Add space above the text
                  Text(
                    'Enter Passcode',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 80),
                  Align(
                    alignment: Alignment.centerLeft, 
                    child: Text(
                      'ENTER PASSCODE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true, // This will hide the entered text
                    decoration: InputDecoration(
                      labelText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to New Password screen after submitting passcode
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                    ),
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
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

class NewPasswordScreen extends StatelessWidget {
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
              'Create New Password',
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
                    'ENTER NEW PASSWORD',
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
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'RE-ENTER NEW PASSWORD',
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
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
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
