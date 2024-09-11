import 'package:flutter/material.dart';
import 'package:main_project/const.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/screens/OTPnew.dart';
import 'package:main_project/screens/cart.dart';
import 'package:main_project/screens/homepage.dart';
import 'package:main_project/screens/orderhistory.dart';
import 'package:main_project/screens/otp.dart';
import 'package:badges/badges.dart' as badges;
import 'package:main_project/screens/otplogin.dart';
import 'package:provider/provider.dart';
// import 'package:main_live_project/view model/common_view_model.dart'; // Adjust the import path as per your project structure

openDraw(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: primaryTextColor,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 30,
                child: Consumer<CommonViewModel>(
                  builder: (context, commonViewModel, _) {
                    String userName =
                        commonViewModel.responser?.getuser?.name ?? '';
                    return Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 5,
                child: Consumer<CommonViewModel>(
                  builder: (context, commonViewModel, _) {
                    String userName =
                        commonViewModel.responser?.getuser?.phone ?? '';
                    return Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            navigateToHomePage(context);
          },
        ),
        Consumer<CartProvider>(
          builder: (context, cartProvider, _) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align the text and the badge to opposite ends
                children: [
                  const Text('My Cart'),
                  SizedBox(width: 5), // Add spacing between text and badge
                  if (cartProvider.cartProducts.length >
                      0) // Show badge only if there are items in the cart
                    CircleAvatar(
                      backgroundColor: primaryButtonColor2,
                      radius:
                          15, // Adjust the size of the badge according to your design
                      child: Text(
                        cartProvider.cartProducts.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              onTap: () {
                navigateToCartPage(context);
              },
            );
          },
        ),
        ListTile(
          title: const Text('Order History'),
          onTap: () {
            navigateToOrderHistoryPage(context);
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(
              color: Colors.redAccent.shade700,
              fontWeight: FontWeight.w900,
            ),
          ),
          onTap: () {
            logout(context);
          },
        ),
      ],
    ),
  );
}

void navigateToHomePage(BuildContext context) {
  Navigator.pop(context);
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => HomePage()),
  // );
}

void navigateToCartPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CartPage()),
  );
}

void navigateToOrderHistoryPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
  );
}

void logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              performLogout(context); // Call the logout function
            },
            child: Text("Logout"),
          ),
        ],
      );
    },
  );
}

Future<void> performLogout(BuildContext context) async {
  // Your logout logic goes here
  // For example, clearing the data and navigating to the login screen
   await Store.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => AuthScreen1()),
    (route) => false,
  );
}
