import 'dart:developer' as cccc;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Import the package
import 'package:main_project/const.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/prodet.dart';
import 'package:main_project/shimmer%20widgets/shimmerfruits.dart';
import 'package:main_project/view%20model/popularvm.dart';
import 'package:main_project/view%20model/productsvm.dart';
import 'package:main_project/webservice/webservice.dart';
// import 'package:main_live_project/widgets/shimmer.dart';
import 'package:provider/provider.dart';

class FruitsPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;

  FruitsPage({required this.categoryId, required this.categoryTitle});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  CommonViewModel? vm;
  final ScrollController _scrollController = ScrollController();
  int productCurrentpage = 1;
  int searchProductCurrentpage = 1;
  List<productsviewmodel> _searchItems = [];
  List<productsviewmodel> _searchpaginationItems = [];
  bool isSearch = false;
  bool isloading = true;
  bool searchscroll = false;
  bool testing = false;
  String? enteredKeywords;
  @override
  void initState() {
    Provider.of<CommonViewModel>(context, listen: false).Vegitablelist.clear();
    Provider.of<CommonViewModel>(context, listen: false)
        .getVegitable1(productCurrentpage, "viewall", 0, widget.categoryId)
        .then((value) => _searchItems = value)
        .then((value) => isloading = false);
    Provider.of<CommonViewModel>(context, listen: false)
        .getsearchVegitable(1, "", "ccc", 0, widget.categoryId);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchItems.clear();
    _searchpaginationItems.clear();

    super.dispose();
  }

  void _onScroll() {
    cccc.log("qqqqqqqqqqqqqqqqqqqqqqqqqqq---$isSearch");
    if (isSearch == false) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productCurrentpage++;
        var itemViewModel =
            Provider.of<CommonViewModel>(context, listen: false);
        itemViewModel.getVegitable1(
            productCurrentpage, '', 0, widget.categoryId);
      }
      // productCurrentpage = 1;
    } else {
      if (vm!.checking == true) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          searchProductCurrentpage++;
          var itemViewModel =
              Provider.of<CommonViewModel>(context, listen: false);
          itemViewModel
              .getsearchVegitable(searchProductCurrentpage, enteredKeywords!,
                  "ccc", 0, widget.categoryId)
              .then(
            (value) {
              _searchpaginationItems.addAll(vm!.searchVegitablelist);
            },
          );
        }
      }
    }
  }

  void _runFilter(String enteredKeyword) {
    isSearch = true;
    testing = true;
    vm = Provider.of<CommonViewModel>(context, listen: false);

    List<productsviewmodel> results = [];
    List<productsviewmodel> searchresults = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearch = false;
      });

      results = vm!.Vegitablelist;
    } else {
      setState(() {
        enteredKeywords = enteredKeyword;
      });

      if (testing == true) {
        vm!
            .getsearchVegitable(1, enteredKeyword, "ccc", 0, widget.categoryId)
            .then((value) => searchresults = vm!.Vegitablelist
                .where((item) => item.products.title
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()))
                .toList())
            .then((value) {
          setState(() {
            _searchpaginationItems = searchresults;
          });
        }).then((value) {
          setState(() {
            testing = false;
          });
        });
      }
    }

    setState(() {
      _searchItems = results;
    });
    cccc.log("_searchpaginationItems == ${_searchpaginationItems.length}");

    cccc.log("dddddddddddddddd == $isSearch");
  }

  @override
  Widget build(BuildContext context) {
    cccc.log("ddddddddddd");
    vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primarycontainerColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: TextFormField(
                          cursorColor: primaryTextColor,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Search ..',
                          ),
                          onChanged: (value) {
                            _searchpaginationItems.clear();
                            searchProductCurrentpage = 1;
                            _runFilter(value);
                          },
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<CommonViewModel>(builder: (context, category, child) {
                return isloading == true
                    ? const Center(child: Shimmerfruits())
                    // LoadServicesWidget(
                    //     page: "ss",
                    //   )
                    : isSearch == true
                        ? testing == true
                            ? const Center(child: Shimmerfruits())
                            // LoadServicesWidget(
                            //     page: "ss",
                            //   )
                            : _searchpaginationItems.isEmpty
                                ? const Center(child: Text("No data"))
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2.0,
                                      crossAxisSpacing: 2.0,
                                      children: List.generate(
                                          _searchpaginationItems.length,
                                          (index) {
                                        final product =
                                            _searchpaginationItems[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                  popular: popularviewmodel(
                                                      items: PopulaR(
                                                          normalsize:
                                                              product.weight,
                                                          id: product.id,
                                                          title: product.titlex,
                                                          description: product
                                                              .descriptionx,
                                                          productImage:
                                                              product.imagx,
                                                          price: product.price,
                                                          acprice:
                                                              product.price,
                                                          selectedVariant: 0,       variantName:"0",)),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Image.network(
                                                      APIservice.mainurl +
                                                          product.imagx,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7.0),
                                                  Text(
                                                    product.titlex,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5,
                                                                horizontal: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colors
                                                              .primaries[Random()
                                                                  .nextInt(Colors
                                                                      .primaries
                                                                      .length)]
                                                              .withOpacity(0.2),
                                                        ),
                                                        child: Text(
                                                          product.weight
                                                                  .toString() +
                                                              ' kg',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        product.price
                                                                .toString() +
                                                            "/-",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .green.shade900,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                        : _searchItems.isEmpty
                            ? const Center(child: Text("No data"))
                            : Container(
                                height: MediaQuery.of(context).size.height,
                                child: StaggeredGrid.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2.0,
                                  crossAxisSpacing: 2.0,
                                  children: List.generate(_searchItems.length,
                                      (index) {
                                    final product = _searchItems[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              popular: popularviewmodel(
                                                  items: PopulaR(
                                                      normalsize:
                                                          product.weight,
                                                      id: product.id,
                                                      title: product.titlex,
                                                      description:
                                                          product.descriptionx,
                                                      productImage:
                                                          product.imagx,
                                                      price: product.price,
                                                      acprice: product.price,
                                                      selectedVariant: 0,       variantName:"0",)),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Image.network(
                                                  APIservice.mainurl +
                                                      product.imagx,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(height: 7.0),
                                              Text(
                                                product.titlex,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 6),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Colors.primaries[
                                                              Random().nextInt(
                                                                  Colors
                                                                      .primaries
                                                                      .length)]
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Text(
                                                      product.weight
                                                              .toString() +
                                                          ' kg',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    product.price.toString() +
                                                        "/-",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.green.shade900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
              })
            ],
          ),
        ),
      ),
    );
  }
}
