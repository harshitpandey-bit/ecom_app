
import 'package:ecommers_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_page.dart';
 // Ensure this path is correct

class ProductDetailsPage extends StatelessWidget {
  final Map product;
  final CartController cartController = Get.put(CartController());

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(product['image']),
              SizedBox(height: 20),
              Text(product['description']),
              SizedBox(height: 20),
              Text('\$${product['price']}', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.to(() => CartPage());
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
