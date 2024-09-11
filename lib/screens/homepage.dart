import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:main_project/const.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:main_project/screens/allproducts.dart';
import 'package:main_project/screens/fruits.dart';
// import 'package:main_live_project/shimmer%20widgets/shimmercategorypage.dart';
import 'package:main_project/shimmer%20widgets/shimmerpopular.dart';
import 'package:main_project/shimmer%20widgets/shimmertopitem.dart';
import 'package:main_project/shimmer%20widgets/shimmeruser.dart';
// import 'package:main_live_project/view%20model/categoryvm.dart';
import 'package:main_project/view%20model/getuservm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:main_project/view%20model/popularvm.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/categories.dart';
import 'package:main_project/screens/meats.dart';
import 'package:main_project/screens/prodet.dart';
import 'package:main_project/webservice/webservice.dart';
import 'package:main_project/widgets/drawerwidget.dart';
import 'package:main_project/shimmer%20widgets/shimmercategory.dart';
import 'package:main_project/widgets/exitappdialog.dart';
import 'package:main_project/widgets/viewall.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:shimmer/shimmer.dart'; // Import your OTP screen here

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

Future<bool> exit(context) async {
  final shouldPop = await showDialog<bool>(
    context: context,
    builder: (context) {
      return exitappalert(context);
    },
  );
  return shouldPop!;
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CommonViewModel? vm;
  String? username;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getConnectivity();
     
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.gethomeCategory('', 1);

    vm!.getpopularitems();

       _fetchUserData();


       log("00001");
    
  }

  Future<void> _fetchUserData() async {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    final getuserviewmodel? userModel = await vm?.get_user();
    if (userModel != null) {
    setState(() {
      
        username = userModel.getuser.name;
  
      isLoading = false;
    });
        }

    // setState(() {

    // });
  }
late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;

        log("isdeviceconnected ==== $isDeviceConnected");
        if (!isDeviceConnected && isAlertSet == false) {
          log("no internet connection ");
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      } as void Function(List<ConnectivityResult> event)?,
    );
  }





// check internet connection alertbox
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text(
            'No Connection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Quicksand",
            ),
          ),
          content: const Text(
            'Please check your internet connectivity',
            style: TextStyle(
              fontFamily: "Quicksand",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand",
                  color: primaryButtonColor2,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
     vm = Provider.of<CommonViewModel>(context);
    return WillPopScope(
        onWillPop: () async=>exit(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          endDrawer: Drawer(
            // Your drawer content here
            child: openDraw(context),
          ),
          body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(backgroundColor: Colors.white,
                    floating: true,
                    snap: true,
                    automaticallyImplyLeading: false,
                    title: isLoading
                        ? shimmeruser()
                        : username == null
                            ? Center(child: Text('User data is null'))
                            : Container(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hey $username,',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'What do you like to find',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ), // Adding some space between the texts and the title category
                    viewalll(
                      txt: "Category",
                      onPressedx: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesPage()),
                        );
                      },
                    ),

                    Consumer<CommonViewModel>(
                        builder: (context, category, child) {
                      if (category.categoryload) {
                        return const Center(child: ShimmerWidget());
                      } else {
                        return Container(
                          height: 65,
                          margin: EdgeInsets.all(
                              4), // Adjust the height of the container
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: category.homecategorylist1
                                .length, // Use filteredItems.length here
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (category.homecategorylist1[index].subx ==
                                      1) {
                                    // Navigate to a page displaying subcategories
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MeatsPage(
                                          catid: category
                                              .homecategorylist1[index].id,
                                          catname: category
                                              .homecategorylist1[index].titlex,
                                        ),
                                      ),
                                    );
                                  } else {
                                    //  Navigate to a page displaying products
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FruitsPage(
                                            categoryId: category
                                                .homecategorylist1[index].id,
                                            categoryTitle: category
                                                .homecategorylist1[index]
                                                .titlex),
                                      ),
                                    );
                                  }
                                  // Handle onTap event here
                                  // print(
                                  //     'Item tapped: ${filteredItems[index].titlex}');
                                },
                                child: Container(
                                  width: 110,
                                  height:
                                      100, // Adjust the width of the container
                                  margin: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[
                                        200], // Adjust the background color
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        4.0), // Add padding inside the container
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the value as needed
                                            color: Colors.grey
                                                .shade200, // Optional: specify a background color
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10), // Same value as the outer container
                                            child: Image.network(
                                              APIservice.mainurl +
                                                  category
                                                      .homecategorylist1[index]
                                                      .imagex,
                                              // filteredItems[index].imagex,
                                              height: 35,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width:  8),
                                        Text(
                                          category
                                              .homecategorylist1[index].titlex,
                                          // filteredItems[index].titlex,
                                          style: TextStyle(
                                              fontSize:
                                                  15), // Adjust the font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),

                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ), // Add space below the category
                    Consumer<CommonViewModel>(
      builder: (context, vm, child) {
        if (vm.popularload) {
          return Shimmerpopular();
        } else if (vm.popularitems.isEmpty) {
          return Center(
            child: Shimmerpopular(),
          );
        } else {
          return Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: vm.popularitems.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          popular: popularviewmodel(
                            items: vm.popularitems[index].items,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          APIservice.mainurl +
                              vm.popularitems[index].imagepop.toString(),
                          height: 100,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vm.popularitems[index].titlepop.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                vm.popularitems[index].descriptionpop!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    vm.popularitems[index].pricex.toString() +
                                        "/-",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          int id = vm.popularitems[index].id!;
                                          String name = vm.popularitems[index].titlepop!;
                                          String image = vm.popularitems[index].imagepop!;

                                          PopulaR cartProduct = PopulaR(
                                            id: id,
                                            title: name,
                                            description: vm.popularitems[index].descriptionpop,
                                            productImage: image,
                                            price: vm.popularitems[index].pricex,
                                            quantity: vm.popularitems[index].quantityx!,
                                            acprice: vm.popularitems[index].pricee,
                                            selectedVariant: 0,
                                            variantName:"0",
                                            normalsize: vm.popularitems[index].weight,
                                          );

                                          CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

                                          bool isDuplicate = cartProvider.cartProducts.any((item) => item.id == cartProduct.id);

                                          if (!isDuplicate) {
                                            cartProvider.addItem(cartProduct);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Item added to cart'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Item is already in the cart'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: MediaQuery.of(context).size.width / 200,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ),
          );
        }
      },
    ),

                    viewalll(
                      txt: "Top Items",
                      onPressedx: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Allproducts()),
                        );
                      },
                    ),
                    Consumer<CommonViewModel>(
      builder: (context, topitem, child) {
        if (topitem.popularload) {
          return Shimmertopitem();
        } else if (topitem.popularitems.isEmpty) {
          return Center(
            child: Shimmertopitem(),
          );
                        } else {
                          return StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            children: List.generate(
                                vm!.popularitems.length > 4
                                    ? 4
                                    : vm!.popularitems.length,
                                (index) => Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                popular: popularviewmodel(
                                                    items: vm!
                                                        .popularitems[index]
                                                        .items),
                                              ),
                                            ),
                                          );
                                          print('Button clicked!');
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey[100],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                APIservice.mainurl +
                                                    vm!.popularitems[index]
                                                        .imagepop!, // Path to your image asset
                                                // Take the full width
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the whole area
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                vm!.popularitems[index]
                                                    .titlepop!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color:
                                                          Colors.red.shade100,
                                                    ),
                                                    child: Text(
                                                      '1 kg',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    vm!.popularitems[index]
                                                            .pricex
                                                            .toString() +
                                                        "/-", // Sample price
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}