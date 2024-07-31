import 'package:ecommers_app/controller/cart_controller.dart';
import 'package:ecommers_app/sceens/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Obx(() {
        return cartController.cartItems.isEmpty
            ? Center(child: Text('No items in the cart'))
            : ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final product = cartController.cartItems[index];
            return ListTile(
              leading: Image.network(product['image'], width: 50, height: 50),
              title: Text(product['title']),
              subtitle: Text('\$${product['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                onPressed: () => cartController.removeFromCart(product),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Get.to(() => AddressPaymentPage());
        },
        child: Text('Proceed to Payment'),
      ),
    );
  }
}
