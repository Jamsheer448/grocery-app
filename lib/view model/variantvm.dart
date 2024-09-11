import 'package:main_project/model/variantmodel.dart';

class variantviewmodel{
  final Variant variants;
  variantviewmodel({required this.variants});

  int get idx{
    return this.variants.id;
  }

  int get Productid{
    return this.variants.productid;
  }

   int get Variantid{
    return this.variants.variantid;
  }

   String get productname{
    return this.variants.productName;
  }

 int get sizeid{
    return this.variants.sizeid;
  }

String get productimage{
    return this.variants.image;
  }

  String get sizename{
    return this.variants.sizename;
  }

  int get price{
    return this.variants.price;
  }

  }