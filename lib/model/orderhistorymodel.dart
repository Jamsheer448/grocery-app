// import 'dart:developer';

// class Order {
//   final int orderId;
//   final String orderDate;
//   final String totalAmount;
//   final String status;
//   final String quantity;
// final String delivery_date;
//   Order({
//     required this.orderId,
//     required this.orderDate,
//     required this.totalAmount,
//     required this.status,
//     required this.delivery_date,
//     required this.quantity,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//   log("id=====" + json['id'].toString());
//   log("od=====" + json['order_date']);
//   log("ta=====" + json['total_amount']);
//   log("st=====" + json['status']);
// log("pw=====" + json['quantity']);
// log("dd=====" + json['delivery_date']);


//   return Order(
//     orderId: json['id'],
//     orderDate: json['order_date'],
//     totalAmount: json['total_amount'],
//     status: json['status'],
//     quantity: json['quantity'],
// delivery_date: json['delivery_date']
//   );
// }

// }
// // 

// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:main_project/model/variantmodel.dart';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));


class Order {
   final String id;
   final String username;
   final String orderDate;
   final String deliveryDate;
   final String status;
   final String totalAmount;
   final String quantity;
   final List<Product> products;

    Order({
      required  this.id,
       required this.username,
       required this.orderDate,
      required  this.deliveryDate,
       required this.status,
      required  this.totalAmount,
       required this.quantity,
       required this.products,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"].toString(),
        username: json["username"],
        orderDate: json["order_date"] ,
        deliveryDate: json["delivery_date"], 
        status: json["status"].toString(),
        totalAmount: json["total_amount"].toString(),
        quantity: json["quantity"].toString(),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );


}

class Product {
   final String? price;
   final String? productName;
  final  String? image;
   final String? quantity;
   final String? pricevarient;
      final String? variame;
    // final int? variame;
    //  final List<Variant>? variants; 

    Product({
       required this.price,
        required this.productName,
       required this.image,
       required this.quantity,
       required this.pricevarient,
      //  required   this.selectedVariant,
      required this.variame,

          
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"].toString(),
        productName: json["product_name"].toString(),
        image: json["image"],
        quantity: json["quantity"].toString(),
        pricevarient: json["pricevarient"].toString(),
              variame: json["variame"].toString(),
    //     selectedVariant: json["selectedVariant"],
    //     variants: json[""],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "product_name": productName,
        "image": image,
        "quantity": quantity,
           "variame": variame,
              // "selectedVariant": selectedVariant,
    };
}

enum Status {
    DELIVERED,
    PENDING
}

final statusValues = EnumValues({
    "Delivered": Status.DELIVERED,
    "Pending": Status.PENDING
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
