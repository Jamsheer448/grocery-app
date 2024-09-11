
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
import 'package:main_project/shimmer%20widgets/shimmercategorypage.dart';
import 'package:main_project/view%20model/categoryvm.dart';
import 'package:main_project/webservice/webservice.dart';

import 'package:provider/provider.dart';

class MeatsPage extends StatefulWidget {
  int catid;String catname;
   MeatsPage({super.key,required this.catid,required this.catname});

  @override
  State<MeatsPage> createState() => _CategroyViewAllState();
}

class _CategroyViewAllState extends State<MeatsPage> {
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
    Provider.of<CommonViewModel>(context, listen: false).subcategorylist.clear();
    Provider.of<CommonViewModel>(context, listen: false)
        .getSubcategory(productCurrentpage, widget.catid, "viewall")
        .then((value) => _searchItems = value)
        .then((value) => isloading = false);
    Provider.of<CommonViewModel>(context, listen: false)
        .getSearchsubCategory(1, widget.catid,"", "ccc" );
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
        itemViewModel.getSubcategory(productCurrentpage, widget.catid, "viewall");
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
          itemViewModel.getSearchsubCategory(
              searchProductCurrentpage,widget.catid, enteredKeywords!, "ccc", );
          _searchpaginationItems.addAll(vm!.searchsubcategorylist);
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

      results = vm!.subcategorylist;
    } else {
      setState(() {
        enteredKeywords = enteredKeyword;
      });

      log("qqq----$enteredKeyword");

      if (testing == true) {
        log("testing value === $testing");
        vm!
            .getSearchsubCategory(1,widget.catid, enteredKeyword, "ccc", )
            .then((value) => searchresults = vm!.searchsubcategorylist
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
        title:  Text(
         widget.catname,
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
                                                        MeatsPage(catid: _searchpaginationItems[index].id,catname: _searchpaginationItems[index].itemsx.toString(),),
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
                                                    MeatsPage(
                                                    catid: _searchItems[index].id,
                                                    catname: _searchItems[index].titlex,
                                                    ),
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








// import 'package:flutter/material.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/shimmer%20widgets/shimmercategorypage.dart';
// import 'package:main_live_project/view%20model/categoryvm.dart';
// import 'package:main_live_project/webservice/webservice.dart';
// import 'package:main_live_project/shimmer%20widgets/shimmercategory.dart';
// import 'package:provider/provider.dart';
// import 'fruits.dart'; // Import FruitsPage widget

// class MeatsPage extends StatefulWidget {
//   @override
//   State<MeatsPage> createState() => _MeatsPageState();
// }

// class _MeatsPageState extends State<MeatsPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   CommonViewModel? vm;

//   late final List<categoryviewmodel> filteredItems;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     filteredItems.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     vm = Provider.of<CommonViewModel>(context, listen: false);
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(
//           'Meats',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search..',
//                   border: InputBorder.none,
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),

//             // filteredItems.isEmpty?
//             FutureBuilder(
//               future: vm!.getCategory1212(1, "viewall", 1),
//               builder: (BuildContext context,
//                   AsyncSnapshot<List<categoryviewmodel>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child:
//                         const shimmercategory(), // Display a shimmer effect while loading
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                         'Error: ${snapshot.error}'), // Display an error message if fetching fails
//                   );
//                 } else {
//                   // final List<categoryviewmodel>
//                   filteredItems = snapshot.data!
//                       .where((item) => item.parentx == 1)
//                       .toList();

//                   if (filteredItems.isEmpty) {
//                     return Center(
//                       child: Text('No items available'),
//                     );
//                   }

//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: filteredItems.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(30),
//                           child: Card(
//                             elevation: 0,
//                             child: Container(
//                               padding: EdgeInsets.all(10.0),
//                               color: Colors.grey.shade100,
//                               child: ListTile(
//                                 leading: Image.network(
//                                   APIservice.mainurl +
//                                       filteredItems[index].imagex,
//                                   width: 50,
//                                   height: 50,
//                                 ),
//                                 title: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       filteredItems[index].titlex,
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Total Items: ${filteredItems[index].itemsx.toString()}",
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 onTap: () {
//                                   // Navigate to FruitsPage and pass the category ID
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => FruitsPage(
//                                           categoryId: filteredItems[index].id,
//                                           categoryTitle:
//                                               filteredItems[index].titlex),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             )
//             //:SizedBox(child: Text("dattttaaa"),)
//           ],
//         ),
//       ),
//     );
//   }
// }
