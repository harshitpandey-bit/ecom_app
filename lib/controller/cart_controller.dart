import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map>[].obs;

  void addToCart(Map product) {
    cartItems.add(product);
  }

  void removeFromCart(Map product) {
    cartItems.remove(product);
  }
}
