import 'package:main_project/model/categorymodel.dart';
// import 'package:sample_ui_project/model/model.dart';

class categoryviewmodel{
  final Category datas;
  categoryviewmodel({required this.datas});
  int get id{
    return this.datas.id;
  }

  String get titlex {
    return this.datas.categoryname;
  }

  int get itemsx {
    return this.datas.totalItems;
  }

   int get subx {
    return this.datas.subcategory;
  }

   int get parentx {
    return this.datas.parentcategoryid;
  }

   String get imagex {
    return this.datas.categoryimage;
  }
}