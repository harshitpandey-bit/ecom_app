import 'package:ecommers_app/sceens/login_screen.dart';
import 'package:ecommers_app/sceens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_52PiWXcRxf8JGzi9BIAPxqhWtbhqVe1oTv2z7hwaRCQWSFkHBfY0NHDAK1YQRxAqSzc5mxyVHxqP82A0sYtfxRAVT00BnFvHsx9';
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
    );
  }
}