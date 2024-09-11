
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:main_live_project/const.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/view%20model/categoryvm.dart';
// import 'package:main_live_project/webservice/webservice.dart';

// import 'package:provider/provider.dart';

// class CategroyViewAll1212 extends StatefulWidget {
//   const CategroyViewAll1212({super.key});

//   @override
//   State<CategroyViewAll1212> createState() => _CategroyViewAllState();
// }

// class _CategroyViewAllState extends State<CategroyViewAll1212> {
//   final ScrollController _scrollController = ScrollController();
//   int productCurrentpage = 1;
//   int searchProductCurrentpage = 1;
//   List<categoryviewmodel> _searchItems = [];
//   List<categoryviewmodel> _searchpaginationItems = [];
//   bool isSearch = false;
//   bool isloading = true;
//   bool searchscroll = false;
//   bool testing = false;
//   String? enteredKeywords;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CommonViewModel>(context, listen: false).categorylist.clear();
//     Provider.of<CommonViewModel>(context, listen: false)
//         .getCategory1212(productCurrentpage, "viewall")
//         .then((value) => _searchItems = value)
//         .then((value) => isloading = false);
//     Provider.of<CommonViewModel>(context, listen: false)
//         .getSearchcategory1212(1, "", "ccc");
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     log("qqqqqqqqqqqqqqqqqqqqqqqqqqq---$isSearch");
//     if (isSearch == false) {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         productCurrentpage++;
//         var itemViewModel =
//             Provider.of<CommonViewModel>(context, listen: false);
//         itemViewModel.getCategory1212(productCurrentpage, '');
//       }
//       // productCurrentpage = 1;
//     } else {
//       log("serch addd");
//       if (vm!.checking == true) {
//         if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//           searchProductCurrentpage++;
//           var itemViewModel =
//               Provider.of<CommonViewModel>(context, listen: false);
//           itemViewModel.getSearchcategory1212(
//               searchProductCurrentpage, enteredKeywords!, "ccc");
//           _searchpaginationItems.addAll(vm!.searchcategorylist);
//         }
//       }
//     }
//   }

//   void _runFilter(String enteredKeyword) {
//     isSearch = true;
//     testing = true;
//     vm = Provider.of<CommonViewModel>(context, listen: false);

//     List<categoryviewmodel> results = [];
//     List<categoryviewmodel> searchresults = [];
//     if (enteredKeyword.isEmpty) {
//       setState(() {
//         isSearch = false;
//       });

//       results = vm!.categorylist;
//     } else {
//       setState(() {
//         enteredKeywords = enteredKeyword;
//       });

//       log("qqq----$enteredKeyword");

//       if (testing == true) {
//         log("testing value === $testing");
//         vm!
//             .getSearchcategory1212(1, enteredKeyword, "ccc")
//             .then((value) => searchresults = vm!.searchcategorylist
//                 .where((item) => item.titlex
//                     .toLowerCase()
//                     .contains(enteredKeyword.toLowerCase()))
//                 .toList())
//             .then((value) {
//           setState(() {
//             _searchpaginationItems = searchresults;
//           });
//         }).then((value) {
//           setState(() {
//             testing = false;
//           });
//         });
//       }
//     }

//     setState(() {
//       _searchItems = results;
//     });
//     log("_searchpaginationItems == ${_searchpaginationItems.length}");

//     log("dddddddddddddddd == $isSearch");
//   }

//   CommonViewModel? vm;

//   @override
//   Widget build(BuildContext context) {
//     vm = Provider.of<CommonViewModel>(context, listen: false);
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Navigator.push(context, MaterialPageRoute(
//               //   builder: (context) {
//               //     return HomeScreen();
//               //   },
//               // ));
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: primaryTextColor,
//             )),
//         title: const Text(
//           "Categories",
//           style: TextStyle(
//               color: primaryTextColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 15),
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
//                   borderRadius: BorderRadius.circular(20),
//                   color: primarycontainerColor),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.search,
                      
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Flexible(
//                         child: TextFormField(
//                       cursorColor: primaryTextColor,
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Search ..',
//                       ),
//                       onChanged: (value) {
//                         _searchpaginationItems.clear();
//                         searchProductCurrentpage = 1;
//                         _runFilter(value);
//                       },
//                     ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           ///////////////////////////////////////////////////////////////////////////////////
//           Expanded(child:
//               Consumer<CommonViewModel>(builder: (context, category, child) {
//             return isloading == true
//                 ? const Text("Loading .. ")
//                 // LoadServicesWidget(
//                 //     page: "ss",
//                 //   )
//                 : isSearch == true
//                     ? testing == true
//                         ? const Text("Loading .. ")
//                         // LoadServicesWidget(
//                         //     page: "ss",
//                         //   )
//                         : _searchpaginationItems.isEmpty
//                             ? const Center(child: Text("No data"))
//                             : Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ListView.builder(
//                                   itemCount: _searchpaginationItems.length,
//                                   // categorylist.length,
//                                   itemBuilder: (context, index) {
//                                     String item = _searchpaginationItems[index]
//                                                 .subx ==
//                                             0
//                                         ? " Products"
//                                         : " Subcategories";
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: InkWell(
//                                         borderRadius: BorderRadius.circular(20),
//                                         onTap: () {
//                                           // categorylist[index].flag == 1
//                                           //     ? Navigator.push(context, MaterialPageRoute(
//                                           //         builder: (context) {
//                                           //           return SubCategory(
//                                           //             category: categorylist[index].categoryname,
//                                           //             ishome: 1,
//                                           //           );
//                                           //         },
//                                           //       ))
//                                           //     : Navigator.push(context, MaterialPageRoute(
//                                           //         builder: (context) {
//                                           //           return CategoryProducts(
//                                           //             category: categorylist[index].categoryname,
//                                           //             productlist: index == 1
//                                           //                 ? vegItem
//                                           //                 : index == 0
//                                           //                     ? topItem
//                                           //                     : fruitsItem,
//                                           //             ishome: 0,
//                                           //           );
//                                           //         },
//                                           //       ));
//                                         },
//                                         child: Container(
//                                           // height: 100,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               color: primarycontainerColor1),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(15),
//                                             child: Row(
//                                               children: [
//                                                 ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     child: Image.network(
//                                                       APIservice.mainurl
//                                                                +
//                                                           _searchpaginationItems[
//                                                                   index]
//                                                               .imagex,
//                                                       width: 50,
//                                                       height: 50,
//                                                       fit: BoxFit.contain,
//                                                     )),
//                                                 const SizedBox(
//                                                   width: 15,
//                                                 ),
//                                                 Flexible(
//                                                   child: SizedBox(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                             .size
//                                                             .width,
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           _searchpaginationItems[
//                                                                   index]
//                                                               .titlex
//                                                               .toString(),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style: const TextStyle(
//                                                               fontSize: 15,
//                                                               color:
//                                                                   primaryTextColor,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                         _searchpaginationItems[
//                                                                         index]
//                                                                     .itemsx ==
//                                                                 0
//                                                             ? const SizedBox()
//                                                             : Text(
//                                                                 _searchpaginationItems[
//                                                                             index]
//                                                                         .itemsx
//                                                                         .toString() +
//                                                                     item,
//                                                                 // " Items",
//                                                                 style: const TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color:
//                                                                         primarySubTextColor,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal),
//                                                               )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               )
//                     : _searchItems.isEmpty
//                         ? const Center(child: Text("No data"))
//                         : Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListView.builder(
//                               controller: _scrollController,
//                               itemCount: _searchItems.length,
//                               // categorylist.length,
//                               itemBuilder: (context, index) {
//                                 String item =
//                                     _searchItems[index].subx == 0
//                                         ? " Products"
//                                         : " Subcategories";
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     borderRadius: BorderRadius.circular(20),
//                                     onTap: () {
//                                       // categorylist[index].flag == 1
//                                       //     ? Navigator.push(context, MaterialPageRoute(
//                                       //         builder: (context) {
//                                       //           return SubCategory(
//                                       //             category: categorylist[index].categoryname,
//                                       //             ishome: 1,
//                                       //           );
//                                       //         },
//                                       //       ))
//                                       //     : Navigator.push(context, MaterialPageRoute(
//                                       //         builder: (context) {
//                                       //           return CategoryProducts(
//                                       //             category: categorylist[index].categoryname,
//                                       //             productlist: index == 1
//                                       //                 ? vegItem
//                                       //                 : index == 0
//                                       //                     ? topItem
//                                       //                     : fruitsItem,
//                                       //             ishome: 0,
//                                       //           );
//                                       //         },
//                                       //       ));
//                                     },
//                                     child: Container(
//                                       // height: 100,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           color: primarycontainerColor1),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(15),
//                                         child: Row(
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               child: Image.network(
//                                                 APIservice.mainurl +
//                                                     _searchItems[index].imagex,
//                                                 width: 50,
//                                                 height: 50,
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               width: 15,
//                                             ),
//                                             Flexible(
//                                               child: SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       _searchItems[index]
//                                                           .titlex
//                                                           .toString(),
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                           fontSize: 15,
//                                                           color:
//                                                               primaryTextColor,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     _searchItems[index]
//                                                                 .itemsx ==
//                                                             0
//                                                         ? const SizedBox()
//                                                         : Text(
//                                                             _searchItems[index]
//                                                                     .itemsx
//                                                                     .toString() +
//                                                                 item,
//                                                             style: const TextStyle(
//                                                                 fontSize: 12,
//                                                                 color:
//                                                                     primarySubTextColor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .normal),
//                                                           )
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//           }))
//         ],
//       ),
//     );
//   }
// }