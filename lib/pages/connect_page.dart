import 'package:flutter/material.dart';
import 'package:my_portfolio/Util/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class LetsConnectPage extends StatefulWidget {
  const LetsConnectPage({super.key});

  @override
  _LetsConnectPageState createState() => _LetsConnectPageState();
}

class _LetsConnectPageState extends State<LetsConnectPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade700),
  );

  // Send message function
  Future<void> sendMessage() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final message = _messageController.text;

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      // If fields are empty, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields!')),
      );
      return;
    }

    final url = Uri.parse('http://localhost:5000/contact'); // Your backend URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message sent successfully!')),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        // Failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message. Please try again later.')),
        );
      }
    } catch (e) {
      // Catch any errors and show them
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      appBar: AppBar(
        backgroundColor: CustomColor.scaffoldBg,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Detect desktop vs mobile view
          bool isDesktop = constraints.maxWidth > 800;

          // Centralized container for large screens
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 600 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Get in Touch",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isDesktop ? 45 : 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 50),

                    Text(
                      "Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                      ),
                    ),

                    SelectableText(
                      "namanvarur1@proton.me",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.amberAccent
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Name Field
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Message Field
                    TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Message",
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: inputBorder.copyWith(
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: inputBorder,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Send Message Button
                    TextButton(
                      onPressed: sendMessage,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Send Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
