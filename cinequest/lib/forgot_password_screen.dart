import 'package:cinequest/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart';
import 'package:cinequest/mongodb.dart';
import 'package:provider/provider.dart'; // Ensure this is correctly imported to use MongoDatabase

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // TextEditingController instances for each input field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reNewPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _newPasswordController.dispose();
    _reNewPasswordController.dispose();
    super.dispose();
  }

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
                  _buildTextField('ENTER YOUR EMAIL', controller: _emailController),
                  SizedBox(height: 20),
                  _buildTextField('ENTER YOUR USERNAME', controller: _usernameController),
                  SizedBox(height: 20),
                  _buildTextField('ENTER NEW PASSWORD', controller: _newPasswordController, obscureText: true),
                  SizedBox(height: 20),
                  _buildTextField('RE-ENTER NEW PASSWORD', controller: _reNewPasswordController, obscureText: true),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      // Implement the logic for updating the password here
                      if (_newPasswordController.text != _reNewPasswordController.text) {
                        // Show an alert if the passwords do not match
                        _showAlert('Error', 'The passwords do not match.');
                        return;
                      }
                      final success = await MongoDatabase.updateUserPassword(
                        _emailController.text,
                        _usernameController.text,
                        _newPasswordController.text,
                      );
                      if (success) {
                        // Navigate to home screen or show a success message
                        Provider.of<MovieModel>(context, listen: false).setUserEmail(_emailController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(userEmail: _emailController.text)),
                        );
                      } else {
                        // Show an error message
                        _showAlert('Error', 'Failed to update the password. Please check your credentials.');
                      }
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

  Widget _buildTextField(String label, {bool obscureText = false, required TextEditingController controller}) {
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
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
