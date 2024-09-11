class PopulaR {
  final int id;
  final String? title;
  final String? description;
  final String? productImage;
  int quantity;
  final int? price;
  final int? acprice;
  final int? selectedVariant;
  final int? normalsize;
   final String? variantName;

  PopulaR({
    required this.id,
    required this.title,
    required this.description,
    required this.productImage,
    this.quantity = 1,
    required this.price,
    required this.acprice,
    required this.selectedVariant,
    required this.normalsize,
    required this.variantName,
  });

  factory PopulaR.fromJson(Map<String, dynamic> json) {
    return PopulaR(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      productImage: json["product_image"],
      price: json["price"],
      acprice: json['acprice'],
      selectedVariant: json['selected_variant'] ?? 0,
      normalsize: json['normalsize'],
     variantName: json['variant_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "quantity": quantity,
        "product_image": productImage,
        "price": price,
        "acprice": acprice,
        "selectedVariant": selectedVariant,
        "normalsize": normalsize,
         "variant_name": variantName,
      };
}
