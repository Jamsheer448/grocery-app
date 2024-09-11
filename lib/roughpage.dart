





// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';




//  StaggeredGridView.countBuilder(
//                             physics: BouncingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: items.length,
//                             crossAxisCount: 2,
//                             itemBuilder: (context, index) {
//                               // final procduct = snapshot.data![index];
//                               return InkWell(
//                                 onTap: () {
//                                   log("clicked");
//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) {
//                                       return DetailsPage(
//                                           id: procduct.id!,
//                                           name: procduct.productname!,
//                                           image: Webservice().imageurl +
//                                               procduct.image!,
//                                           price: procduct.price.toString(),
//                                           description: procduct.description!);
//                                     },
//                                   ));
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Column(
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(15),
//                                               topRight: Radius.circular(15)),
//                                           child: Container(
//                                             constraints: const BoxConstraints(
//                                                 minHeight: 100, maxHeight: 250),
//                                             child: Image(
//                                                 image: NetworkImage(
//                                               Webservice().imageurl +
//                                                   procduct.image!,
//                                             )),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             children: [
//                                               Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Text(
//                                                   procduct.productname!,
//                                                   maxLines: 2,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                       color:
//                                                           Colors.grey.shade600,
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ),
//                                               Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Text(
//                                                   'Rs. ${procduct.price}',
//                                                   //  "2000",
//                                                   style: TextStyle(
//                                                       color:
//                                                           Colors.red.shade900,
//                                                       fontSize: 17,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             staggeredTileBuilder: (context) =>
//                                 const StaggeredTile.fit(1)),