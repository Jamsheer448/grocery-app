import 'dart:developer';

import 'package:main_project/model/variantmodel.dart';

class Products {
   final int id;
  final  String title;
   final String description;
   final int catid;
   final String productImage;
   final int price;
  //  final int? selectedVariant;
  // final List<Variant>? variants; 
  final int normalsize;

    Products({
      required  this.id,
       required this.title,
       required this.description,
       required this.catid,
       required this.price,
       required this.productImage,
      //  required this.selectedVariant,
      //  required this.variants,
       required this.normalsize
    });

    factory Products.fromJson(Map<String, dynamic> json) {



    //  log("eeee----"+json["variants"].toString());
      return Products(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        catid: json["catid"],
        productImage: json["product_image"],
        price: json["price"],
        // selectedVariant: json["selectedVariant"],
        // variants: json["variants"] != null
        //     ? List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x)))
        //     : null,
            normalsize: json["normalsize"],
    );
    }
}