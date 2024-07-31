import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> signup() async {
    isLoading.value = true;

    final String username = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final String apiUrl = 'https://78aba79a-42ba-4454-8808-844af251d771-00-39zbu6qwiz388.worf.replit.dev/'; // Replace with your Node.js server URL
   print(email);
    try {
      final headers = {'Content-Type': 'application/json'};
      final data =  {
        'username': username,
        'email': email,
        'password': password,
      };
      final body =jsonEncode(data);
      final response = await http.post(Uri.parse(apiUrl + "signup"),headers: headers, body:body);

      if (response.statusCode == 200) {
        // Handle successful signup
        print('Signup successful');
        Get.snackbar('Signup Successful', 'You can now login');
      } else {
        // Handle other status codes (e.g., 400, 401, etc.)
        print('Signup failed: ${response.statusCode}');
        Get.snackbar('Signup Failed', 'Failed to create account');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error during signup: $e');
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

class SignupScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Obx(() => signupController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: signupController.usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: signupController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: signupController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signupController.signup,
              child: Text('Signup'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
