class Category{
   final int id;
   final String categoryname;
   final String categoryimage;
   final int subcategory;
   final int parentcategoryid;
   final int totalItems;

    Category({
      required  this.id,
       required this.categoryname,
      required  this.categoryimage,
      required  this.subcategory,
      required  this.parentcategoryid,
      required  this.totalItems,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryname: json["title"],
        categoryimage: json["product_image"],
        subcategory: json["subcategory"],
        parentcategoryid: json["parentcategoryid"],
        totalItems: json["total_items"],
    );
}