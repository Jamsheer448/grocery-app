import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:main_project/model/categorymodel.dart' as ccccc;
import 'package:main_project/model/categorymodel.dart';
import 'package:main_project/model/getusermodel.dart';
import 'package:main_project/model/orderhistorymodel.dart';
// import 'package:main_live_project/model/ordermodel.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/model/productmodel.dart';
import 'package:main_project/model/responsemodel.dart';
import 'package:main_project/model/variantmodel.dart';
import 'package:main_project/provider/sharedprefernce.dart';

class APIservice {
  // static final mainurl = "http://192.168.29.215/fooddelivery/images/";
  static final mainurl = "https://shihab.addsgo.com/fooddelivery/images/";
  //  'http://192.168.29.215:8080/Liveproject/images/';
  // static const URL = "http://192.168.29.215/fooddelivery/api/";
  static const URL = "https://shihab.addsgo.com/fooddelivery/api/";
  //  "http://192.168.29.215:8080/Liveproject/";

////////////////////////////////////////////////////////////////////////

  // get categoty
  Future<List<Category>?> getMailCategory(String query, page) async {
    try {
      final response = await Dio().post("${URL}get_category.php",
          data: {"searchkey": query.toString(), "page": page.toString()});
      log("category statuscode === " + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("category response ==== " + response.data.toString());
        List<Category> category = [];

        for (var userData in response.data) {
          category.add(Category.fromJson(userData));
        }

        return category;
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //get subcategory

  Future<List<Category>?> getSubCategory(String query, page, catid) async {
    try {
      final response = await Dio().post("${URL}sub_category.php", data: {
        "searchkey": query.toString(),
        "page": page.toString(),
        "categoryid": catid.toString()
      });
      log("subcategory statuscode === " + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("subcategory response ==== " + response.data.toString());
        List<Category> category = [];

        for (var userData in response.data) {
          category.add(Category.fromJson(userData));
        }

        return category;
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  ////
  ///
  ///
  //get friuts varient

// Future<List<Category>?> getfritandvegserch(String query, page,catid) async {
//     try {
//       final response = await Dio().post("${URL}sub_category.php",
//           data: {"searchkey": query.toString(), "page": page.toString(),"categoryid":catid.toString()});
//       log("subcategory statuscode === " + response.statusCode.toString());
//       if (response.statusCode == 200) {
//         log("subcategory response ==== " + response.data.toString());
//         List<Product> category = [];

//         for (var userData in response.data) {
//           category.add(Category.fromJson(userData));
//         }

//         return category;

//       } else {
//         throw Exception("Unable to perform request!");
//       }
//     } catch (e) {
//       log(e.toString());
//       return [];
//     }
//   }
  ///
  ///
  //

/////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<Category>?> getCategory1212(String query, page, int type) async {
    try {
      log("searchkey ======================================= " +
          query.toString());
      log("page =================================== " + page.toString());
      final response = await Dio().post("${URL}get_category.php", data: {
        "searchkey": query.toString(),
        "page": page.toString(),
        "type": type
      });
      log("category statuscode === " + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("category response ==== " + response.data.toString());
        List<Category> category = [];

        for (var userData in response.data) {
          category.add(Category.fromJson(userData));
        }

        return category;
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

///////////////////////////////////////////////////////////////////////////
  Future<ResponseModel> duplicate_user(
    phonenumber,
  ) async {
    Map<String, dynamic> data = {
      'phonenumber': phonenumber,
    };
    final response = await Dio().post(
      URL + "duplireg.php",
      data: data,
    );
    //log(response.statusCode.toString());
    log("message");
    if (response.statusCode == 200) {
      log("user  =  ${response.data}");
      final Map<String, dynamic> responseData = response.data;
      log("user 2 =  $responseData");
      var userData = responseData;
      return ResponseModel.fromJson(userData);
    } else {
      throw Exception('Failed to load register user');
    }
  }

  Future<Map<String, dynamic>> createAccount(
    String phoneNumber,
    String shopName,
    String shoplocation,
    String name,
  ) async {
    try {
      final Map<String, dynamic> userData = {
        'phonenumber': phoneNumber,
        'shopname': shopName,
        'shoplocation': shoplocation,
        'name': name,
      };

      final response = await Dio().post(
        URL + 'createaccount.php',
        data: userData,
      );

      if (response.statusCode == 200) {
        // Check if Content-Type is JSON
        if (response.headers.map['content-type']!
            .contains('application/json')) {
          // Parse JSON response
          ResponseModel ws = ResponseModel.fromJson(jsonDecode(response.data));
          return {
            'status': true,
            'msg': 'Success',
            'WebService': ws,
          };
        } else {
          // Handle non-JSON response
          // For example, if the response is plain text
          String responseData = response.data.toString();
          return {
            'status': true,
            'msg': responseData,
          };
        }
      } else {
        // Handle error
        return {
          'status': false,
          'msg': 'Failed to create account',
        };
      }
    } catch (e) {
      // Handle exceptions
      print('Error occurred: $e');
      return {
        'status': false,
        'msg': 'Error occurred: $e',
      };
    }
  }

  Future<GetUser> getUser() async {
    String? username = await Store.getUsername();
    log("username:" + username!);

    final Map<String, dynamic> userData = {
      'username': username,
    };

    try {
      // Make GET request
      final response = await Dio().post(URL + 'get_user.php', data: userData);

      print("rrrrrrrr----" + response.data.toString());

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        return GetUser.fromJson(response.data);
      } else {
        // If the server returns a non-200 response, throw an exception.
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      // Handle Dio errors
      log('Dio error get user: $e');
      throw Exception('Failed to load user data');
    }
  }

  Future<List<Category>> getProducts(String query, String page) async {
    try {
      print("Inside");
      final response = await Dio().post(URL + "get_category.php",
          data: {"searchkey": query.toString(), "page": page.toString()});

      if (response.statusCode == 200) {
        print(response.data.toString());
        final List<dynamic> data = response.data;
        // log('data='+data.toString());
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Category');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Category>?> getCategory() async {
    log("inside category ========================================================");
    try {
      final response = await Dio()
          .post("${URL}get_category.php", data: {"searchkey": "", "page": "1"});
      log("category statuscode === " + response.statusCode.toString());
      if (response.statusCode == 200) {
        log("category response ==== " + response.data.toString());
        List<Category> category = [];

        for (var userData in response.data) {
          category.add(Category.fromJson(userData));
        }

        return category;
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<PopulaR>> getPopularitems(String searchkey, page) async {
    try {
      print("Inside");
      final response = await Dio()
          .post(URL + "popular.php", data: {"searchkey": "", "page": "1"});

      if (response.statusCode == 200) {
        print(response.statusCode);
        final List<dynamic> data = response.data;
        // log('data='+data.toString());
        return data.map((json) => PopulaR.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Category');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<PopulaR>> getallitems() async {
    try {
      print("Inside");
      final response = await Dio().get(URL + "popular.php");

      if (response.statusCode == 200) {
        print(response.statusCode);
        final List<dynamic> data = response.data;
        // log('data='+data.toString());
        return data.map((json) => PopulaR.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Category');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // Define a method to fetch category data

  Future<List<Products>> fetchProducts(String searchkey, page,catid) async {
    try {
      // Make a POST request to the API endpoint with pagination and query parameters
      final response = await Dio().post(
        URL + "products.php",
        data: {
          "searchkey": searchkey,
          "page": page,
          "catid":catid
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        log("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq------------------" +
            response.data.toString());
        // Parse the JSON response
        final List<dynamic> jsonData = response.data;

        // Convert JSON data into a list of Products objects
        List<Products> products = jsonData.map((item) {
          return Products.fromJson(item);
        }).toList();

        log("dataloded------------------");

        // Return the list of Products objects
        return products;
      } else {
        // If the request was not successful, throw an error
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // If an error occurs during the HTTP request, throw an error
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> Takeorder(
    List<PopulaR> cart,
    String username,
    String order_date,
    String total_amount,
    String delivery_date,
    String quantity,
    String status,
  ) async {
    String jsondata = jsonEncode(cart);
    log('jsondata =$jsondata');

    try {
      final Map<String, dynamic> userData = {
        'cart': cart,
        'username': username,
        'order_date': order_date,
        'total_amount': total_amount,
        'delivery_date': delivery_date,
        'quantity': quantity,
        'status': status,
      };
      log("takeorder ============= " + userData.toString());
      final response = await Dio().post(
        URL + 'order.php',
        data: jsonEncode(userData),
      );

      log("messageeeeeeeeeeeeeeeeeeeeeeee");

      if (response.statusCode == 200) {
        // Check if Content-Type is JSON
        if (response.headers.map['content-type']!
            .contains('application/json')) {
          // Parse JSON response
          ResponseModel ws = ResponseModel.fromJson(jsonDecode(response.data));
          return {
            'status': true,
            'msg': 'success',
            'WebService': ws,
          };
        } else {
          // Handle non-JSON response
          // For example, if the response is plain text
          String responseData = response.data.toString();
          return {
            'status': true,
            'msg': responseData,
          };
        }
      } else {
        // Handle error
        return {
          'status': false,
          'msg': 'Failed to create account',
        };
      }
    } catch (e) {
      // Handle exceptions
      print('Error occurred: $e');
      return {
        'status': false,
        'msg': 'Error occurred: $e',
      };
    }
  }

  Future<List<Order>> OrderHistory() async {
    try {
      // Get the username from the shared preferences
      String? username = await Store.getUsername();
      log("username:" + username!);

      // Prepare the request payload
      final Map<String, dynamic> userData = {
        'username': username,
      };

      // Make a POST request to the API endpoint with the username
      final response = await Dio().post(
        //  "http://192.168.29.215:8080/Liveproject/orderhistory.jsp",
        URL + 'orderhistory.php',
        data: jsonEncode(userData),
      );

      log("aaaaa----" + response.data.toString());
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = response.data;

        // Convert JSON data into a list of Order objects
        List<Order> orders = jsonData.map((item) {
          return Order.fromJson(item);
        }).toList();

        // Return the list of Order objects
        return orders;
      } else {
        // If the request was not successful, throw an error
        throw Exception('Failed to load order history');
      }
    } catch (e) {
      // If an error occurs during the HTTP request, throw an error
      throw Exception('Error: $e');
    }
  }

  Future<List<Variant>> fetchvariants(int id) async {
    try {
      final Map<String, dynamic> userData = {
        'productid': id,
      };
      // Make an HTTP GET request to the API endpoint
      final response =
          await Dio().post(URL + "itemvariant.php", data: jsonEncode(userData));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = response.data;

        // Convert JSON data into a list of Products objects
        List<Variant> variants = jsonData.map((item) {
          return Variant.fromJson(item);
        }).toList();

        // Return the list of Products objects
        return variants;
      } else {
        // If the request was not successful, throw an error
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // If an error occurs during the HTTP request, throw an error
      throw Exception('Error: $e');
    }
  }
}
