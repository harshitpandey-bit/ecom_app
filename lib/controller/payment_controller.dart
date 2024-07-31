import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  Future<Map<String, dynamic>> createPaymentIntent(String amount) async {
    String apiUrl = 'https://78aba79a-42ba-4454-8808-844af251d771-00-39zbu6qwiz388.worf.replit.dev/';
    final response = await http.post(
      Uri.parse(apiUrl+'create-payment-intent'), // Replace with your server URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amount,
        'currency': 'usd',
      }),
    );
    return jsonDecode(response.body);
  }

  void processPayment() async {
    if (formKey.currentState!.validate()) {
      try {
        final paymentIntent = await createPaymentIntent('1000'); // Example amount in cents
        final clientSecret = paymentIntent['clientSecret'];

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            applePay: PaymentSheetApplePay(merchantCountryCode: 'US'),
            googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
            style: ThemeMode.system,
            merchantDisplayName: 'Your Merchant Name',
          ),
        );

        await Stripe.instance.presentPaymentSheet();

        Get.snackbar('Success', 'Payment processed successfully');
      } catch (e) {
        Get.snackbar('Error', 'Payment failed: $e');
      }
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    nameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}
