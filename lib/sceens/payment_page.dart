import 'package:ecommers_app/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressPaymentPage extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Address and Payment Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              ExpansionTile(
                title: Text('Address Details'),
                children: [
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.cityController,
                    decoration: InputDecoration(labelText: 'City'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.zipController,
                    decoration: InputDecoration(labelText: 'ZIP Code'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ZIP code';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Payment Details'),
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: 'Name on Card'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name on card';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.cardNumberController,
                    decoration: InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your card number';
                      } else if (value.length != 16) {
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.expiryDateController,
                    decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the expiry date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controller.cvvController,
                    decoration: InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the CVV';
                      } else if (value.length != 3) {
                        return 'CVV must be 3 digits';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.processPayment,
                child: Text('Submit Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
