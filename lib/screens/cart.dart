import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:main_project/const.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/webservice/webservice.dart';
import 'package:main_project/screens/splash.dart';
import 'package:main_project/widgets/cartbutton.dart';
import 'package:main_project/widgets/custombox.dart';
import 'package:provider/provider.dart';
import 'package:main_project/provider/providers.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

bool load = false;

class _CartPageState extends State<CartPage> {
  CommonViewModel? vm;
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'My Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete, color: primaryButtonColor2),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
            ),
          ],
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartItems, child) {
            List<PopulaR> cartProducts = cartItems.cartProducts;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cartProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'Your Cart is Empty',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: cartProducts.length,
                          itemBuilder: (context, index) {
                            final item = cartProducts[index];

                        //    log("vari----"+item.selectedVariant.toString());

// if(item.selectedVariant==0){
//   log("aaaaaaaaaaaaa");
// }else{
//   log("data-----"+item.variantName.toString());
// }

                            return Container(
                              height: 100,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.network(
                                      APIservice.mainurl + item.productImage!,
                                      height: 50,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title!,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),

                                                item.selectedVariant==0?SizedBox(height: 14,):
                                                Text(
                                                 item.variantName.toString() , // Display the variant price here
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w100,
                                                    color:primaryButtonColor2,
                                                  ),
                                                ),
                                               
                                                Text(
                                                  '${item.acprice} /-', // Display the variant price here
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 28,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        color: item.quantity ==
                                                                1
                                                            ? null
                                                            : Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          iconSize: 10,
                                                          icon: item.quantity ==
                                                                  1
                                                              ? const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white30)
                                                              : const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white),
                                                          onPressed: () {
                                                            item.quantity == 1
                                                                ? null
                                                                :

                                                                // Implement decrease functionality for the item
                                                                Provider.of<CartProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .reduceByOne(
                                                                        item);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () {
                                                        TextEditingController
                                                            _textFieldController =
                                                            TextEditingController();
                                                        alertdialog(
                                                            context,
                                                            _textFieldController,
                                                            item);
                                                      },
                                                      child: Text(
                                                        '${item.quantity} Kg', // Display the default quantity
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.red[300],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Container(
                                                      height: 28,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          iconSize: 10,
                                                          icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white),
                                                          onPressed: () {
                                                            Provider.of<CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .increment(
                                                                    item);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 13,
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeItem(item),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 80),
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          primaryButtonColor2,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
        bottomNavigationBar: Provider.of<CartProvider>(context).cartProducts.isEmpty
                  ?null :BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ${Provider.of<CartProvider>(context).calculateTotalAmount} /-',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Provider.of<CartProvider>(context).cartProducts.isEmpty
                  ? Text(
                      '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    )
                  : load
                      ? CircularProgressIndicator()
                      : cartbutton(
                          teeext: 'Order Now',
                          onPresssed: () async {
                            setState(() {
                              load = true;
                            });
                            // Retrieve username from storage
                            String? username = await Store.getUsername();

                            // Check if username is available
                            if (username != null && username.isNotEmpty) {
                              // Retrieve cart products
                              List<PopulaR> cart = Provider.of<CartProvider>(
                                      context,
                                      listen: false)
                                  .cartProducts;

                              // Check if cart is not empty
                              if (cart.isNotEmpty) {
                                // Prepare order date
                                String orderDate = DateTime.now().toString();

                                // Calculate total amount
                                double totalAmount = Provider.of<CartProvider>(
                                        context,
                                        listen: false)
                                    .calculateTotalAmount;
                                int totalproducts = Provider.of<CartProvider>(
                                        context,
                                        listen: false)
                                    .cartProducts
                                    .length;

                                // Calculate delivery date (7 days from now)
                                DateTime deliveryDate =
                                    DateTime.now().add(const Duration(days: 7));

                                // Set quantity (if needed)
                                String quantity = totalproducts
                                    .toString(); // Assuming this is a constant value

                                // Set order status
                                String status = 'Pending';

                                // Call the function to send order data to backend
                                try {
                                  Map<String, dynamic> result =
                                      await vm!.takeOrder(
                                    cart,
                                    username,
                                    orderDate,
                                    totalAmount.toString(),
                                    deliveryDate.toString(),
                                    totalproducts.toString(),
                                    status,
                                  );

                                  // Handle the response
                                  if (result['status']) {
                                    // Order placed successfully
                                    // Clear the cart
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .clearCart();

                                    setState(() {
                                      load = false;
                                    });

                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 4),
                                        behavior: SnackBarBehavior.floating,
                                        padding: EdgeInsets.all(15.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        content: Text(
                                          "Your Order Successfully Completed",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );

                                    // Navigate to another screen if needed
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                    );
                                  } else {
                                    // Failed to place order
                                    // Show error message
                                    print(
                                        'Failed to place order: ${result['msg']}');
                                  }
                                } catch (e) {
                                  // Handle exceptions
                                  // Show error message
                                  print(
                                      'Error occurred while placing order: $e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 4),
                                      behavior: SnackBarBehavior.floating,
                                      padding: const EdgeInsets.all(15.0),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      content: Text(
                                        "Error occurred while placing order: $e",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                // Cart is empty
                                // Show empty cart message
                                print("");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 4),
                                    behavior: SnackBarBehavior.floating,
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    content: Text(
                                      "Your Cart is Empty",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              // Username is not available
                              // Handle accordingly (e.g., show login prompt)
                              print('Username not available');
                            }
                          },
                        ),
            ],
          ),
        ));
  }
}
