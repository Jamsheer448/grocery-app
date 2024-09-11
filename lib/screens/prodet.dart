import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:main_project/const.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/cart.dart';
import 'package:main_project/view%20model/popularvm.dart';

import 'package:main_project/webservice/webservice.dart';
import 'package:main_project/widgets/cartbutton.dart';
import 'package:main_project/widgets/counterwidget.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailScreen extends StatefulWidget {
  final popularviewmodel popular;

  ProductDetailScreen({required this.popular});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int? selectedVariantId;
  CommonViewModel? vm;
  int quantity = 1; // Variable to store the quantity
  int selectedPrice = 0; 
    String selectedvarientname =""; // Variable to store the selected variant price
  int selectedSizeIndex = -1; // Variable to store the selected size index

  @override
  void initState() {
    super.initState();

    log("inside init");

    selectedPrice = widget.popular.pricex ??
        0; // Set the initial price, default to 0 if null
    Provider.of<CommonViewModel>(context, listen: false)
        .getvariants(widget.popular.id!);
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    int totalPrice = selectedPrice * quantity;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 20,
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
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return IconButton(
                icon: badges.Badge(
                  badgeContent: Text(
                    cartProvider.cartProducts.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: primaryButtonColor2,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Image.network(
                      APIservice.mainurl + widget.popular.imagepop!,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            widget.popular.titlepop!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          vm!.variantload
                              ? const CircularProgressIndicator()
                              : vm!.variantitems.length == 0
                                  ? const SizedBox.shrink()
                                  : Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Size:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // Wrap(
                                        //   children: List.generate(10,(index) {
                                        //     return Padding(
                                        //       padding: const EdgeInsets.all(8.0),
                                        //       child: Container(
                                        //         height: 50,
                                        //         width: 100,
                                        //         color: Colors.black,
                                        //       ),
                                        //     );
                                        //   },),
                                        // ),
                                        Wrap(
                                          spacing:
                                              10, // Adjust spacing between items
                                          runSpacing:
                                              10, // Adjust spacing between rows
                                          children: List.generate(
                                              vm!.variantitems.length,
                                              (index) {
                                            var variant =
                                                vm!.variantitems[index];
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedSizeIndex = index;
                                                  selectedVariantId =
                                                      variant.idx;
                                                  selectedPrice =
                                                      variant.price;

                                                      selectedvarientname= variant.sizename;

                                                });
                                              },
                                              child: Container(
                                                width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.4), // Adjust width to fit two items per row
                                                padding:
                                                    const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: selectedSizeIndex ==
                                                            index
                                                        ? primaryButtonColor2
                                                        : Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    variant.sizename ,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          primaryButtonColor2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$selectedPrice /-',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              CounterWidget(
                                onQuantityChange: (value) {
                                  setState(() {
                                    quantity = value;
                                    totalPrice = selectedPrice * quantity;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.popular.descriptionpop!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: ${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            cartbutton(
              teeext: 'Add to Cart',
              onPresssed: () {
                PopulaR cartProduct = PopulaR(
                    id: widget.popular.id!,
                    title: widget.popular.titlepop,
                    description: widget.popular.descriptionpop,
                    productImage: widget.popular.imagepop,
                    price: selectedPrice,
                    quantity: quantity,
                    acprice:
                        selectedPrice, // Use the selected variant price here
                    selectedVariant:
                        selectedVariantId == null ? 0 : selectedVariantId!,
                        
                    normalsize: widget.popular.weight,

                    variantName:selectedvarientname
                    
                    
                    );

                CartProvider cartProvider =
                    Provider.of<CartProvider>(context, listen: false);

                bool isDuplicate = cartProvider.cartProducts.any((item) =>
                    item.id == cartProduct.id &&
                    item.selectedVariant == cartProduct.selectedVariant);

                if (!isDuplicate) {
                  cartProvider.addItem(cartProduct);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item is already in the cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
