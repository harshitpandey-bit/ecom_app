import 'dart:convert';
import 'package:ecommers_app/sceens/product_page.dart';
import 'package:ecommers_app/sceens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    // Replace with your Node.js server URL
    final String apiUrl = 'https://78aba79a-42ba-4454-8808-844af251d771-00-39zbu6qwiz388.worf.replit.dev/';
    final headers = {'Content-Type': 'application/json'};

    final data = {
      'email': email,
      'password': password,
    };
    final body = jsonEncode(data);

    try {
      final response = await http.post(Uri.parse(apiUrl + "login"), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final String token = jsonData['token'];

        // Store token locally using shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Navigate to ProductPage upon successful login
        Get.to(() => ProductPage()); // Replace with your ProductPage route
      } else {
        // Handle other status codes (e.g., show error message)
        print('Login failed: ${response.statusCode}');
        Get.snackbar('Login Failed', 'Invalid credentials');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error during login: $e');
      Get.snackbar('Error', 'Failed to connect to server');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

final LoginController loginController = Get.put(LoginController());


class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Obx(() => loginController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: loginController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginController.login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed:()=>Get.to(() => SignupScreen()) ,
              child: Text('Signup'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
