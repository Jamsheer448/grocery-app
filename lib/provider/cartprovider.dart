import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/view%20model/popularvm.dart';
import 'package:main_project/webservice/webservice.dart';


class CartProvider extends ChangeNotifier {
List<PopulaR> _cartProducts = [];
  // String _paymentOption = 'Pay on Delivery'; // Default payment option

  // Get the list of products in the cart
  List<PopulaR> get cartProducts => _cartProducts;

  void addItem(PopulaR product) {
    _cartProducts.add(product);
    notifyListeners();
  }

 void increment(PopulaR product) {
  final index = _cartProducts.indexOf(product);
  if (index != -1) {
    if (_cartProducts[index].quantity != null) {
      _cartProducts[index].quantity = (_cartProducts[index].quantity! + 1);
    } else {
      _cartProducts[index].quantity = 1;
    }
    notifyListeners();
  }
}

// Decrease quantity of a product in the cart
void reduceByOne(PopulaR product) {
  final index = _cartProducts.indexOf(product);
  if (index != -1 && _cartProducts[index].quantity != null && _cartProducts[index].quantity! > 1) {
    _cartProducts[index].quantity = (_cartProducts[index].quantity! - 1);
    notifyListeners();
  }
}


  void updateQuantity(PopulaR product, int newQuantity) {
    final index = _cartProducts.indexOf(product);
    if (index != -1) {
      _cartProducts[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Clear the cart
  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }

  void removeItem(PopulaR product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

 
  double get calculateTotalAmount {
    double total = 0;
    for (var product in _cartProducts) {

      total += product.price! * product.quantity!;
      log(total.toString());
    }
    return total;
  }

  // double get calculateotalAmount {

  //         double total = 0;
  //   for (var product in _cartProducts) {
  //     log('hello');
  //     total += product.price! * product.quantity!;
  //     log(product.quantity.toString());
      
  //   }
  //   return total;
  // }

  void addditem(PopulaR product) {
    // Check if the product is already in the cart
    bool isDuplicate =
        _cartProducts.any((item) => item.id == product.id);

    if (!isDuplicate) {
      // If the product is not already in the cart, add it
      _cartProducts.add(product);
      notifyListeners();
    } else {
      // If the product is already in the cart, you can handle it as needed
      print('Product is already in the cart');
    }
  }

  

  // Future<Map<String, dynamic>> Takeorder(
  //     List<PopulaR> cart,
  //     String username,
  //     String order_date,
  //     String total_amount,
  //     String delivery_date,
  //     String status
      
  //     ) async {
  //   try {
  //     // Call the APIservice method for creating an account
  //     final result = await APIservice().Takeorder(cart, username.toString(),
  //         order_date, total_amount, delivery_date, status);

  //     // You can handle the result here as needed
  //     print("Create Account result: $result");

  //     return result;
  //   } catch (e) {
  //     // Handle any errors that occur during the account creation process
  //     print("Error occurred during account creation: $e");
  //     return {
  //       'status': false,
  //       'msg': 'An error occurred during account creation',
  //     };
  //   }
  // }
}