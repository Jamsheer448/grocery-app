import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/prodet.dart';
import 'package:main_project/shimmer%20widgets/shimmercategorypage.dart';
import 'package:main_project/shimmer%20widgets/shimmerfruits.dart';

import 'package:main_project/view%20model/popularvm.dart';

import 'package:main_project/webservice/webservice.dart';

import 'package:provider/provider.dart';

class Allproducts extends StatefulWidget {
  @override
  State<Allproducts> createState() => _Allproductsstate();
}

class _Allproductsstate extends State<Allproducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CommonViewModel? vm;
  final ScrollController _scrollController = ScrollController();
  int productCurrentpage = 1;
  int searchProductCurrentpage = 1;
  List<popularviewmodel> _searchItems = [];
  List<popularviewmodel> _searchpaginationItems = [];
  bool isSearch = false;
  bool isloading = true;
  bool searchscroll = false;
  bool testing = false;
  String? enteredKeywords;
  @override
  void initState() {
    Provider.of<CommonViewModel>(context, listen: false).popularlist.clear();
    Provider.of<CommonViewModel>(context, listen: false)
        .getPopularitems1(productCurrentpage, "viewall", 0)
        .then((value) => _searchItems = value)
        .then((value) => isloading = false);
    Provider.of<CommonViewModel>(context, listen: false)
        .getsearchpopularproducts(1, "", "ccc", 0);
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
    log("qqqqqqqqqqqqqqqqqqqqqqqqqqq---$isSearch");
    if (isSearch == false) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productCurrentpage++;
        var itemViewModel =
            Provider.of<CommonViewModel>(context, listen: false);
        itemViewModel.getPopularitems1(productCurrentpage, '', 0);
      }
      // productCurrentpage = 1;
    } else {
      log("serch addd");
      if (vm!.checking == true) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          searchProductCurrentpage++;
          var itemViewModel =
              Provider.of<CommonViewModel>(context, listen: false);
          itemViewModel.getsearchpopularproducts(
              searchProductCurrentpage, enteredKeywords!, "ccc", 0);
          _searchpaginationItems.addAll(vm!.searchpopularlistlist);
        }
      }
    }
  }

  void _runFilter(String enteredKeyword) {
    isSearch = true;
    testing = true;
    vm = Provider.of<CommonViewModel>(context, listen: false);

    List<popularviewmodel> results = [];
    List<popularviewmodel> searchresults = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearch = false;
      });

      results = vm!.popularlist;
    } else {
      setState(() {
        enteredKeywords = enteredKeyword;
      });

      log("qqq----$enteredKeyword");

      if (testing == true) {
        log("testing value === $testing");
        vm!
            .getsearchpopularproducts(1, enteredKeyword, "ccc", 0)
            .then((value) => searchresults = vm!.searchpopularlistlist
                .where((item) => item.titlepop.toString()
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
    log("_searchpaginationItems == ${_searchpaginationItems.length}");

    log("dddddddddddddddd == $isSearch");
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap Column in SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search..',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                  ),
                  onChanged: (value) {
                    _searchpaginationItems.clear();
                    searchProductCurrentpage = 1;
                    _runFilter(value);
                  },
                ),
              ),
              SizedBox(height: 10),

              Consumer<CommonViewModel>(builder: (context, product, child) {
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
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      children: List.generate(
                                        _searchpaginationItems.length,
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
                                                        items:
                                                            _searchpaginationItems[
                                                                    index]
                                                                .items),
                                                  ),
                                                ),
                                              );
                                              print('Button clicked!');
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
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
                                                        _searchpaginationItems[
                                                                index]
                                                            .imagepop.toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    _searchpaginationItems[
                                                            index]
                                                        .titlepop.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 4,
                                                                horizontal: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colors
                                                              .red.shade100,
                                                        ),
                                                        child: Text(
                                                          // _searchpaginationItems[
                                                          //             index]
                                                          //         .weight
                                                          //         .toString() +
                                                              '1 kg',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        _searchpaginationItems[
                                                                    index]
                                                                .pricex
                                                                .toString() +
                                                            "/-",
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
                                        ),
                                      ),
                                    ))
                        : _searchItems.isEmpty
                            ? const Center(child: Text("No data"))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  children: List.generate(
                                    _searchItems.length,
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
                                                    items: _searchItems[index]
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
                                                    _searchItems[index]
                                                        .imagepop.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                _searchItems[index].titlepop.toString(),
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
                                                      // _searchItems[index]
                                                      //         .weight
                                                      //         .toString() +
                                                          '1 kg',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    _searchItems[index]
                                                            .pricex
                                                            .toString() +
                                                        "/-",
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
                                    ),
                                  ),
                                ));
              })
              // FutureBuilder(
              //   future: vm!.getallitems(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<popularviewmodel>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Shimmerfruits();
              //     } else if (snapshot.hasError) {
              //       return Center(
              //         child: Text('Error: ${snapshot.error}'),
              //       );
              //     } else {
              // return
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
