// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:main_live_project/const.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/screens/fruits.dart';
// import 'package:main_live_project/screens/meats.dart';
// import 'package:main_live_project/view%20model/categoryvm.dart';
// import 'package:main_live_project/webservice/webservice.dart';
// import 'package:provider/provider.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage({super.key});

//   @override
//   State<CategoriesPage> createState() => _CategoriesPageState();
// }

// class _CategoriesPageState extends State<CategoriesPage> {
//   final ScrollController _scrollController = ScrollController();
//   int productCurrentPage = 1;
//   int searchProductCurrentPage = 1;
//   List<categoryviewmodel> _searchItems = [];
//   List<categoryviewmodel> _searchPaginationItems = [];
//   bool isSearch = false;
//   bool isLoading = true;
//   bool testing = false;
//   String? enteredKeywords;
//   CommonViewModel? vm;

//   @override
//   void initState() {
//     super.initState();
//     final commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
//     commonViewModel.categorylist.clear();
//     commonViewModel.getCategory1212(productCurrentPage, "viewall", 1).then((value) {
//       _searchItems = value;
//       setState(() {
//         isLoading = false;
//       });
//     });
//     commonViewModel.getSearchcategory1212(1, "", "ccc", 1);
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       if (isSearch) {
//         if (vm!.checking) {
//           searchProductCurrentPage++;
//           vm!.getSearchcategory1212(searchProductCurrentPage, enteredKeywords!, "ccc", 1).then((value) {
//             setState(() {
//               _searchPaginationItems.addAll(vm!.searchcategorylist);
//             });
//           });
//         }
//       } else {
//         productCurrentPage++;
//         vm!.getCategory1212(productCurrentPage, '', 1);
//       }
//     }
//   }

//   void _runFilter(String enteredKeyword) {
//     setState(() {
//       isSearch = true;
//       testing = true;
//       enteredKeywords = enteredKeyword;
//       _searchPaginationItems.clear();
//       searchProductCurrentPage = 1;
//     });

//     if (enteredKeyword.isEmpty) {
//       setState(() {
//         isSearch = false;
//       });
//     } else {
//       vm!.getSearchcategory1212(1, enteredKeyword, "ccc", 1).then((value) {
//         final results = vm!.searchcategorylist.where((item) => item.titlex.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
//         setState(() {
//           _searchPaginationItems = results;
//           testing = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     vm = Provider.of<CommonViewModel>(context);
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: primaryTextColor),
//         ),
//         title: const Text(
//           "Categories",
//           style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 15),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//               height: 45,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: primarycontainerColor,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.search),
//                     const SizedBox(width: 10),
//                     Flexible(
//                       child: TextFormField(
//                         cursorColor: primaryTextColor,
//                         decoration: const InputDecoration.collapsed(
//                           hintText: 'Search ..',
//                         ),
//                         onChanged: (value) => _runFilter(value),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Consumer<CommonViewModel>(
//                     builder: (context, category, child) {
//                       final items = isSearch ? _searchPaginationItems : _searchItems;
//                       if (items.isEmpty) {
//                         return const Center(child: Text("No data"));
//                       }
//                       return ListView.builder(
//                         controller: _scrollController,
//                         itemCount: items.length,
//                         itemBuilder: (context, index) {
//                           final item = items[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(20),
//                               onTap: () {
//                                 if (item.subx == 1) {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => MeatsPage()));
//                                 } else {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => FruitsPage(categoryId: item.id, categoryTitle: item.titlex)));
//                                 }
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: primarycontainerColor1,
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15),
//                                   child: Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Image.network(
//                                           APIservice.mainurl + item.imagex,
//                                           height: 35,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 15),
//                                       Flexible(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               item.titlex,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(fontSize: 15, color: primaryTextColor, fontWeight: FontWeight.bold),
//                                             ),
//                                             if (item.itemsx != 0)
//                                               Text(
//                                                 "${item.subx == 0 ? "Total Products: " : "Subcategories: "}${item.itemsx}",
//                                                 style: const TextStyle(fontSize: 12, color: primaryButtonColor2),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:main_project/const.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/fruits.dart';
import 'package:main_project/screens/meats.dart';
import 'package:main_project/shimmer%20widgets/shimmercategorypage.dart';
import 'package:main_project/view%20model/categoryvm.dart';
import 'package:main_project/webservice/webservice.dart';

import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategroyViewAllState();
}

class _CategroyViewAllState extends State<CategoriesPage> {
  final ScrollController _scrollController = ScrollController();
  int productCurrentpage = 1;
  int searchProductCurrentpage = 1;
  List<categoryviewmodel> _searchItems = [];
  List<categoryviewmodel> _searchpaginationItems = [];
  bool isSearch = false;
  bool isloading = true;
  bool searchscroll = false;
  bool testing = false;
  String? enteredKeywords;

  @override
  void initState() {
    super.initState();
    Provider.of<CommonViewModel>(context, listen: false).categorylist.clear();
    Provider.of<CommonViewModel>(context, listen: false)
        .getCategory1212(productCurrentpage, "viewall", 0)
        .then((value) => _searchItems = value)
        .then((value) => isloading = false);
    Provider.of<CommonViewModel>(context, listen: false)
        .getSearchcategory1212(1, "", "ccc", 0);
    _scrollController.addListener(_onScroll);
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
        itemViewModel.getCategory1212(productCurrentpage, '', 0);
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
          itemViewModel.getSearchcategory1212(
              searchProductCurrentpage, enteredKeywords!, "ccc", 0);
          _searchpaginationItems.addAll(vm!.searchcategorylist);
        }
      }
    }
  }

  void _runFilter(String enteredKeyword) {
    isSearch = true;
    testing = true;
    vm = Provider.of<CommonViewModel>(context, listen: false);

    List<categoryviewmodel> results = [];
    List<categoryviewmodel> searchresults = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearch = false;
      });

      results = vm!.categorylist;
    } else {
      setState(() {
        enteredKeywords = enteredKeyword;
      });

      log("qqq----$enteredKeyword");

      if (testing == true) {
        log("testing value === $testing");
        vm!
            .getSearchcategory1212(1, enteredKeyword, "ccc", 0)
            .then((value) => searchresults = vm!.searchcategorylist
                .where((item) => item.titlex
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

  CommonViewModel? vm;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return HomeScreen();
              //   },
              // ));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primaryTextColor,
            )),
        title: const Text(
          "Categories",
          style: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
      body: Column(
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
          ///////////////////////////////////////////////////////////////////////////////////
          Expanded(child:
              Consumer<CommonViewModel>(builder: (context, category, child) {
            return isloading == true
                ? const Center(child: shimmercategory())
                // LoadServicesWidget(
                //     page: "ss",
                //   )
                : isSearch == true
                    ? testing == true
                        ? const Center(child: shimmercategory())
                        // LoadServicesWidget(
                        //     page: "ss",
                        //   )
                        : _searchpaginationItems.isEmpty
                            ? const Center(child: Text("No data"))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: _searchpaginationItems.length,
                                  // categorylist.length,
                                  itemBuilder: (context, index) {
                                    String item =
                                        _searchpaginationItems[index].subx == 0
                                            ? "Total Products: "
                                            : "Subcategories: ";
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          log("dfghj---" +
                                              _searchItems.length.toString());

                                          _searchpaginationItems[index].subx ==
                                                  1
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MeatsPage(
                                                          catid: _searchpaginationItems[index].id,
                                                          catname: _searchpaginationItems[index].titlex,
                                                        ),
                                                  ))
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => FruitsPage(
                                                          categoryId:
                                                              _searchpaginationItems[
                                                                      index]
                                                                  .id,
                                                          categoryTitle:
                                                              _searchpaginationItems[
                                                                      index]
                                                                  .titlex)));
                                        },
                                        child: Container(
                                          // height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: primarycontainerColor1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      APIservice.mainurl +
                                                          _searchpaginationItems[
                                                                  index]
                                                              .imagex,
                                                      // width: 50,
                                                      height: 35,
                                                      fit: BoxFit.fill,
                                                    )),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _searchpaginationItems[
                                                                  index]
                                                              .titlex
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  primaryTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        _searchpaginationItems[
                                                                        index]
                                                                    .itemsx ==
                                                                0
                                                            ? const SizedBox()
                                                            : Text(
                                                                item +
                                                                    _searchpaginationItems[
                                                                            index]
                                                                        .itemsx
                                                                        .toString(),
                                                                // " Items",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        primaryButtonColor2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                    : _searchItems.isEmpty
                        ? const Center(child: Text("No data"))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: _searchItems.length,
                              // categorylist.length,
                              itemBuilder: (context, index) {
                                log("ttttt");
                                String item = _searchItems[index].subx == 0
                                    ? "Total Products: "
                                    : "Subcategories: ";
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      _searchItems[index].subx == 1
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MeatsPage( catid: _searchItems[index].id,
                                                    catname: _searchItems[index].titlex,),
                                              ))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FruitsPage(
                                                          categoryId:
                                                              _searchItems[
                                                                      index]
                                                                  .id,
                                                          categoryTitle:
                                                              _searchItems[
                                                                      index]
                                                                  .titlex)));
                                    },
                                    child: Container(
                                      // height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primarycontainerColor1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                APIservice.mainurl +
                                                    _searchItems[index].imagex,
                                                height: 40,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Flexible(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _searchItems[index]
                                                          .titlex
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              primaryTextColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    _searchItems[index]
                                                                .itemsx ==
                                                            0
                                                        ? const SizedBox()
                                                        : Text(
                                                            item +
                                                                _searchItems[
                                                                        index]
                                                                    .itemsx
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    primaryButtonColor2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
          }))
        ],
      ),
    );
  }
}
