import 'package:main_project/model/categorymodel.dart';
import 'package:main_project/model/productmodel.dart';
// import 'package:sample_ui_project/model/model.dart';

class productsviewmodel{
  final Products products;
  productsviewmodel({required this.products});
  int get id{
    return this.products.id;
  }

  String get titlex {
    return this.products.title;
  }

  int get catidx {
    return this.products.catid;
  }

  //  String get subx {
  //   return this.products.subcategory;
  // }

   String get descriptionx {
    return this.products.description;
  }

   String get imagx {
    return this.products.productImage;
  }

  //  Products get items {
  //   return this.products;
  // }

  int get price {
    return this.products.price;
  }
   int get weight {
    return this.products.normalsize;
  }
}