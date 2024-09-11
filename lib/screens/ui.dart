// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Import the package
// import 'package:main_live_project/model/popularmodel.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/screens/prodet.dart';
// import 'package:main_live_project/view%20model/popularvm.dart';
// import 'package:main_live_project/view%20model/productsvm.dart';
// import 'package:main_live_project/webservice/webservice.dart';
// // import 'package:main_live_project/widgets/shimmer.dart';
// import 'package:provider/provider.dart';

// import '../shimmer widgets/shimmercategory.dart';

// class FruitPage extends StatefulWidget {
//   final int categoryId;
//   final String categoryTitle;

//   FruitPage({required this.categoryId, required this.categoryTitle});

//   @override
//   State<FruitPage> createState() => _FruitsPageState();
// }

// class _FruitsPageState extends State<FruitPage> {
//   CommonViewModel? vm;

//   @override
//   Widget build(BuildContext context) {
//     vm = Provider.of<CommonViewModel>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.categoryTitle,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 1.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search..',
//                     border: InputBorder.none,
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               FutureBuilder(
//                 future: vm!.getproductitems(),
//                 builder:
//                     (context, AsyncSnapshot<List<productsviewmodel>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return ShimmerWidget();
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     final products = snapshot.data!;

//                     final filteredProducts = products
//                         .where((product) => product.catidx == widget.categoryId)
//                         .toList();

//                         if (filteredProducts.isEmpty) {
//                     return Center(
//                       child: Text('No items available'),
//                     );
//                   }

//                     return Container(
//                       height: MediaQuery.of(context).size.height,
//                       child: StaggeredGrid.count(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 2.0,
//                         crossAxisSpacing: 2.0,
//                         children: List.generate(filteredProducts.length, (index) {
//                           final product = filteredProducts[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductDetailScreen(
//                                       popular: popularviewmodel(items: PopulaR(normalsize:product.weight,id: product.id, title: product.titlex, description: product.descriptionx, productImage: product.imagx,price: product.price, acprice: product.price,selectedVariant: 0)),
//                                     ),
//                                   ),
//                                 );
//                             },
//                             child: Container(
//                               margin: EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Center(
//                                       child: Image.network(
//                                         APIservice.mainurl + product.imagx,
                                        
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     SizedBox(height: 7.0),
//                                     Text(
//                                       product.titlex,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(6),
//                                             color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.2),
//                                           ),
//                                           child: Text(
//                                             '1 kg',
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           product.price.toString() + "/-",
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.green.shade900,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }