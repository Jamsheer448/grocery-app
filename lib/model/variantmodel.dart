class Variant {
   final int id;
   final int productid;
  final  int variantid;
  final  String productName;
   final int sizeid;
  final  String sizename;
  final  String image;
   final int price;

    Variant({
      required this.id,
      required  this.productid,
       required this.variantid,
       required this.productName,
      required  this.sizeid,
      required  this.sizename,
      required  this.image,
      required  this.price,
    });

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
      id: json["variantid"],
        productid: json["productid"],
        variantid: json["variantid"],
        productName: json["product_name"],
        sizeid: json["sizeid"],
        sizename: json["sizename"],
        image: json["image"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
      "id":id,
        "productid": productid,
        "variantid": variantid,
        "product_name": productName,
        "sizeid": sizeid,
        "sizename": sizename,
        "image": image,
        "price": price,
    };
}