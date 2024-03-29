import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset(
                'assets/images/movie_4831192.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Recover Your Password',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField('ENTER YOUR EMAIL'),
                  SizedBox(height: 20),
                  _buildTextField('ENTER PASSWORD', obscureText: true),
                  SizedBox(height: 20),
                  _buildTextField('ENTER NEW PASSWORD', obscureText: true),
                  SizedBox(height: 20),
                  _buildTextField('RE-ENTER NEW PASSWORD', obscureText: true),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to handle the password reset
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
