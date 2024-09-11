// import 'package:main_live_project/model/categorymodel.dart';
import 'package:main_project/model/popularmodel.dart';
// import 'package:sample_ui_project/model/model.dart';

class popularviewmodel{
  final PopulaR items;
  popularviewmodel({required this.items});
  int? get id{
    return this.items.id;
  }

  String? get titlepop {
    return this.items.title;
  }

   String? get descriptionpop {
    return this.items.description;
  }

   int? get quantityx {
    return this.items.quantity;
  }
   String? get imagepop {
    return this.items.productImage;
  }

   int? get pricex {
    return this.items.price;
  }

  int? get pricee {
    return this.items.acprice;
  }

 int? get weight {
    return this.items.normalsize;
  }
  
  int? get selectedVariant {
    return this.items.selectedVariant;
  }
}