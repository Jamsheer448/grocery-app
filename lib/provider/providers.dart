import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:main_project/model/orderhistorymodel.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/model/responsemodel.dart';
import 'package:main_project/view%20model/categoryvm.dart';
import 'package:main_project/view%20model/getuservm.dart';
import 'package:main_project/view%20model/orderhistoryviewmodel.dart';
import 'package:main_project/view%20model/popularvm.dart';
import 'package:main_project/view%20model/productsvm.dart';
import 'package:main_project/view%20model/responsevm.dart';
import 'package:main_project/view%20model/variantvm.dart';
import 'package:main_project/webservice/webservice.dart';

class CommonViewModel extends ChangeNotifier {

  /////////////////////////// NEW  ////////////////////////////////////////////////////////
  ///
  bool _categoryload = false;
  bool get categoryload => _categoryload;
  bool _popularproductload = false;
  bool get popularproductload => _popularproductload;
  bool _hometopitemload = false;
  bool get hometopitemload => _hometopitemload;
  bool _searchcategoryload = false;
  bool get searchcategoryload => _searchcategoryload;
  List<categoryviewmodel> searchcategorylist = [];
  List<categoryviewmodel> homecategorylist = [];
  List<categoryviewmodel> categorylist = [];
  bool hasNextPage = false;
  bool checking = false;

  // home category
    List<categoryviewmodel> homecategorylist1 = [];
    //get category
  Future<List<categoryviewmodel>> gethomeCategory(
      String query, page) async {
    log(" gethomeCategory inside ===== ");
    _categoryload = true;
    notifyListeners();
    final results = await APIservice().getMailCategory(query, page);
    homecategorylist1 =
        results!.map((item) => categoryviewmodel(datas: item)).toList();
    log(homecategorylist1.toString());
    _categoryload = false;
    notifyListeners();
    return homecategorylist1;
  }

  // subcategory
    List<categoryviewmodel> subcategorylist = [];
  List<categoryviewmodel> searchsubcategorylist = [];

   bool _searchsubcategoryload = false;
  bool get searchsubcategoryload => _searchsubcategoryload;

    bool _subcategoryload = false;
  bool get subcategoryload => _subcategoryload;

    List<popularviewmodel> popularlist = [];
  List<popularviewmodel> searchpopularlistlist = [];

   bool _searchpopularload = false;
  bool get searchpopularload => _searchpopularload;

    bool _popularload = false;
  bool get popularload => _popularload;

  
  Future<List<categoryviewmodel>> getSubcategory(
      int page, categoryid, String isclear) async {
    try {
      log("calling isclear getProductitems==============$isclear");
      if (isclear == "home") {
        hasNextPage = true;
      } else if (isclear == "viewall") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }
      //isclear == "home" ? _hasNextPage = true : null;
      _subcategoryload = true;
      log("calling ==================getProductitems==============$hasNextPage");

      if (hasNextPage == true) {
        final results = await APIservice().getSubCategory("", page,categoryid);
        List<categoryviewmodel> nextPage =
            results!.map((item) => categoryviewmodel(datas: item)).toList();
        if (nextPage.isNotEmpty) {
          subcategorylist.addAll(nextPage);
          log("rrrrrrrrrrr ================================================");
          // productCurrentpage++;
          if (subcategorylist.length < 10) {
            hasNextPage = false;
          }
          _subcategoryload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return subcategorylist;
  }

  Future<List<categoryviewmodel>> getSearchsubCategory(
      int page, categoryid, String keyString, String cc) async {
    try {
      log("calling getSearchProductitems============================");
      log("page getSearchProductitems ==================$page");

      if (cc == "ccc") {
        hasNextPage = true;
      } else if (cc == "vv") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      if (hasNextPage == true) {
        _searchsubcategoryload = true;
        final results =
            await APIservice().getSubCategory(keyString, page,categoryid);
        List<categoryviewmodel> nextPage =
            results!.map((item) => categoryviewmodel(datas: item)).toList();
        log("nextPage length ================${nextPage.length}");
        if (nextPage.isNotEmpty) {
          checking = false;
          this.searchsubcategorylist =
              results.map((item) => categoryviewmodel(datas: item)).toList();

          _searchsubcategoryload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return searchsubcategorylist;
  }











  
  ////////////////////////////////////////////////////////////////////////////////
  responseviemodel? response;

  Future<List<categoryviewmodel>> getCategory1212(int page, String isclear, int type) async {
    try {
      log("calling isclear getProductitems==============$isclear");
      if (isclear == "home") {
        hasNextPage = true;
      } else if (isclear == "viewall") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      _categoryload = true;
      log("calling ==================getProductitems==============$hasNextPage");

      if (hasNextPage == true) {
        final results = await APIservice().getCategory1212("", page, type);
        List<categoryviewmodel> nextPage = results!.map((item) => categoryviewmodel(datas: item)).toList();
        if (nextPage.isNotEmpty) {
          categorylist.addAll(nextPage);
          log("rrrrrrrrrrr ================================================");
          _categoryload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return categorylist;
  }

  Future<List<categoryviewmodel>> getSearchcategory1212(int page, String keyString, String cc, int type) async {
    try {
      log("calling getSearchCategoryitems============================");
      log("page getSearchCategoryitems ==================$page");

      if (cc == "ccc") {
        hasNextPage = true;
      } else if (cc == "vv") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      if (hasNextPage == true) {
        _searchcategoryload = true;
        final results = await APIservice().getCategory1212(keyString, page, type);
        List<categoryviewmodel> nextPage = results!.map((item) => categoryviewmodel(datas: item)).toList();
        log("nextPage length ================${nextPage.length}");
        if (nextPage.isNotEmpty) {
          checking = false;
          this.searchcategorylist = results.map((item) => categoryviewmodel(datas: item)).toList();
          _searchcategoryload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return searchcategorylist;
  }

  Future<responseviemodel?> duplicate_user(String phonenumber) async {
    final result = await APIservice().duplicate_user(phonenumber);
    response = responseviemodel(response: result);
    print(">>>result $result");
    return response;
  }

  getuserviewmodel? responser;

  Future<getuserviewmodel?> get_user() async {
    final result = await APIservice().getUser();
    responser = getuserviewmodel(getuser: result);
    print(">>>result $result");
    return responser;
  }

  Future<Map<String, dynamic>> createAccount(String phoneNumber, String shopName, String name, String shoplocation) async {
    try {
      final result = await APIservice().createAccount(phoneNumber, shopName, shoplocation, name);
      print("Create Account result: $result");
      return result;
    } catch (e) {
      print("Error occurred during account creation: $e");
      return {
        'status': false,
        'msg': 'An error occurred during account creation',
      };
    }
  }


  List<popularviewmodel> popularitems = [];
  Future<List<popularviewmodel>> getpopularitems() async {
    final results = await APIservice().getPopularitems("","1");
    this.popularitems = results.map((item) => popularviewmodel(items: item)).toList();
    notifyListeners();
    return this.popularitems;
  }

  

  // List<productsviewmodel> productitems = [];
  // Future<List<productsviewmodel>> getproductitems() async {
  //   final results = await APIservice().fetchProducts("",1,1);
  //   this.productitems = results.map((item) => productsviewmodel(products: item)).toList();
  //   print(productitems);
  //   notifyListeners();
  //   return this.productitems;
  // }
  ///////////////////////////////////
  List<productsviewmodel> Vegitablelist = [];
  List<productsviewmodel> searchVegitablelist = [];

  bool _searchVegitableload = false;
  bool get searchVegitableload => _searchVegitableload;

  bool _Vegitableload = false;
  bool get Vegitableload => _Vegitableload;

  Future<List<productsviewmodel>> getVegitable1(
      int page, String isclear, int type,catid) async {
    try {
      log("calling isclear getProductitems==============$isclear");
      if (isclear == "home") {
        hasNextPage = true;
      } else if (isclear == "viewall") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      _Vegitableload = true;
      log("calling ==================getProductitems==============$hasNextPage");

      if (hasNextPage == true) {
        final results = await APIservice().fetchProducts("", page,catid);
        List<productsviewmodel> nextPage =
            results.map((item) => productsviewmodel(products:item)).toList();
        if (nextPage.isNotEmpty) {
          Vegitablelist.addAll(nextPage);
          log("rrrrrrrrrrr ================================================");
          _Vegitableload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return Vegitablelist;
  }

  Future<List<productsviewmodel>> getsearchVegitable(
      int page, String keyString, String cc, int type,catid) async {
    try {
      log("calling getSearchCategoryitems============================");
      log("page getSearchCategoryitems ==================$page");

      if (cc == "ccc") {
        hasNextPage = true;
      } else if (cc == "vv") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      if (hasNextPage == true) {
        _searchVegitableload = true;
        final results = await APIservice().fetchProducts(keyString, page,catid);
        List<productsviewmodel> nextPage =
            results.map((item) => productsviewmodel(products: item)).toList();
        log("nextPage length ================${nextPage.length}");
        if (nextPage.isNotEmpty) {
          checking = false;
          this.searchVegitablelist =
              results.map((item) => productsviewmodel(products: item)).toList();
          _searchVegitableload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return searchVegitablelist;
  }




  //////////////////////////////////////


  

  List<variantviewmodel> variantitems = [];
  bool variantload = false;
  Future<List<variantviewmodel>> getvariants(int id) async {
    variantload = true;
    notifyListeners();
    final results = await APIservice().fetchvariants(id);
    this.variantitems = results.map((item) => variantviewmodel(variants: item)).toList();
    print("ssssss");
    variantload = false;
    notifyListeners();
    return this.variantitems;
  }

  List<OrderHistoryViewModel> orderItems = [];

  Future<List<OrderHistoryViewModel>> getOrderHistory() async {
    try {
      final List<Order> results = await APIservice().OrderHistory();
      orderItems = results.map((item) => OrderHistoryViewModel(order: item)).toList();
      print(orderItems);
      notifyListeners();
      return orderItems;
    } catch (e) {
      print('Error occurred while fetching order history: $e');
      throw e;
    }
  }


List<popularviewmodel> allitems = [];
  Future<List<popularviewmodel>> getallitems() async {
    final results = await APIservice().getallitems();
    this.allitems = results.map((item) => popularviewmodel(items: item)).toList();
    notifyListeners();
    return this.allitems;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////
  



  Future<List<popularviewmodel>> getPopularitems1(int page, String isclear, int type) async {
    try {
      log("calling isclear getProductitems==============$isclear");
      if (isclear == "home") {
        hasNextPage = true;
      } else if (isclear == "viewall") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      _popularload = true;
      log("calling ==================getProductitems==============$hasNextPage");

      if (hasNextPage == true) {
        final results = await APIservice().getPopularitems("", page);
        List<popularviewmodel> nextPage = results!.map((item) => popularviewmodel(items: item)).toList();
        if (nextPage.isNotEmpty) {
          popularlist.addAll(nextPage);
          log("rrrrrrrrrrr ================================================");
          _popularload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return popularlist;
  }

  Future<List<popularviewmodel>> getsearchpopularproducts(int page, String keyString, String cc, int type) async {
    try {
      log("calling getSearchCategoryitems============================");
      log("page getSearchCategoryitems ==================$page");

      if (cc == "ccc") {
        hasNextPage = true;
      } else if (cc == "vv") {
        if (hasNextPage == false) {
          hasNextPage = true;
        }
      }

      if (hasNextPage == true) {
        _searchpopularload = true;
        final results = await APIservice().getPopularitems(keyString, page);
        List<popularviewmodel> nextPage = results.map((item) => popularviewmodel(items: item)).toList();
        log("nextPage length ================${nextPage.length}");
        if (nextPage.isNotEmpty) {
          checking = false;
          this.searchpopularlistlist = results.map((item) => popularviewmodel(items: item)).toList();
          _searchpopularload = false;
        } else {
          log("no page ==================");
          hasNextPage = false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();

    return searchpopularlistlist;
  }
  ////////////////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>> takeOrder(
    List<PopulaR> cart,
    String username,
    String orderDate,
    String totalAmount,
    String deliveryDate,
    String quantity,
    String status,
  ) async {
    try {
      final result = await APIservice().Takeorder(cart, username, orderDate, totalAmount, deliveryDate, quantity, status);
      if (result['status']) {
        return {
          'status': true,
          'msg': 'Order placed successfully',
        };
      } else {
        return {
          'status': false,
          'msg': result['msg'] ?? 'Failed to place order',
        };
      }
    } catch (e) {
      print("Error occurred during order placement: $e");
      return {
        'status': false,
        'msg': 'An error occurred during order placement: $e',
      };
    }
  }

  List<categoryviewmodel> categoryitems = [];
  Future<List<categoryviewmodel>> getcategoryitemshp() async {
    final results = await APIservice().getCategory();
    this.categoryitems = results!.map((item) => categoryviewmodel(datas: item)).toList();
    print(categoryitems);
    notifyListeners();
    return this.categoryitems;
  }






// getuserviewmodel? _user;
//   bool _isLoading = true;
//   String? _error;

//   getuserviewmodel? get user => _user;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchUser() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _user = await viewModel.get_user();
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }


}
