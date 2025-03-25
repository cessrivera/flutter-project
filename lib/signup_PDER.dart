import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://reqres.in/api/users');
      final Map<String, dynamic> requestData = {
        'last_name': _lastNameController.text,
        'first_name': _firstNameController.text,
        'username': _userNameController.text,
        'password': _passwordController.text,
      };

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData),
        );

        if (response.statusCode == 201) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SuccessPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: Unable to create user")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Network error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.white)), // White text in AppBar
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(color: Colors.white), // White back button
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Last Name"),
              _buildTextField(_lastNameController),
              _buildLabel("First Name"),
              _buildTextField(_firstNameController),
              _buildLabel("Username"),
              _buildTextField(_userNameController),
              _buildLabel("Password"),
              _buildTextField(_passwordController, isPassword: true),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _createUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  child: Text('Create User', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white), // Set label text to white
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white), // Set input text color to white
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // White underline
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple), // Purple underline when focused
        ),
      ),
      validator: (value) => value!.isEmpty ? "Field required" : null,
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Success", style: TextStyle(color: Colors.white)), backgroundColor: Colors.purple),
      body: Center(child: Text("User Created Successfully!", style: TextStyle(fontSize: 18, color: Colors.white))),
    );
  }
}
