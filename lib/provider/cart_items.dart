import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Product> cartItems = [];

  addProduct(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }
}