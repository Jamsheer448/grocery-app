// import 'package:flutter/material.dart';
// import 'package:main_live_project/model/orderhistorymodel.dart';
// import 'package:main_live_project/webservice/webservice.dart';

// class OrderDetails extends StatefulWidget {
//   final int orderId;
//   final String orderDate;
//   final String quantity;List<Product> product;

//   OrderDetails({
//     required this.orderId,
//     required this.orderDate,
//     required this.quantity, required this. product,
//   });

//   @override
//   State<OrderDetails> createState() => _OrderDetailsPageState();
// }

// class _OrderDetailsPageState extends State<OrderDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Order Details',
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
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display order details using widget.orderId, widget.orderDate, etc.
//             Card(
//               color: Colors.grey[200],
//               elevation: 3,
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Order id',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 15,
//                           ),
//                         ),
//                         Text(
//                           widget.orderId.toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.deepOrange.shade900,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.grey,
//                       thickness: 1,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Order Created',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 15,
//                           ),
//                         ),
//                         Text(
//                           widget.orderDate,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.deepOrange.shade900,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       color: Colors.grey,
//                       thickness: 1,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Order Products',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 15,
//                           ),
//                         ),
//                         Text(
//                           widget.quantity.toString(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.deepOrange.shade900,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Products',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.product.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.grey[200],
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListTile(
//                         leading: Image.network( APIservice.mainurl + widget.product[index].image!,),
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                              widget.product[index].productName!,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [

//   widget.product[index].pricevarient=="0"?


//                                 Text(
//                                    widget.product[index].price.toString() + "/-",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.green,
//                                   ),
//                                 ):
//                                   Text(
//                                    widget.product[index].pricevarient.toString() + "/-",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 Text(
//                                 widget.product[index].quantity! + " kg",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.deepOrange.shade900,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:main_project/const.dart';
import 'package:main_project/model/orderhistorymodel.dart';
import 'package:main_project/shimmer%20widgets/shimmerod.dart';
import 'package:main_project/webservice/webservice.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  final String orderDate;
  final String quantity;
  final List<Product> product;

  OrderDetails({
    required this.orderId,
    required this.orderDate,
    required this.quantity,
    required this.product,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetails> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a network call
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.grey[200],
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderDetailRow('Order ID', widget.orderId.toString()),
                    Divider(color: Colors.grey, thickness: 1),
                    _buildOrderDetailRow('Order Created', widget.orderDate),
                    Divider(color: Colors.grey, thickness: 1),
                    _buildOrderDetailRow('Order Products', widget.quantity),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Products',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: isLoading ? ODshimmer() : _buildProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.deepOrange.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      itemCount: widget.product.length,
      itemBuilder: (context, index) {
        final product = widget.product[index];

      var arr = product.quantity!.split('.');
        return Card(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(APIservice.mainurl + product.image!),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (product.pricevarient == "0"
                                ? product.price.toString()
                                : product.pricevarient.toString()) +
                            "/-",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),

                     
                      Text(
                        "${arr[0]} kg",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange.shade900,
                        ),
                      ),
                    ],
                  ),
                   product.variame == "0"
                                ? SizedBox():
                      Text(
                         product.variame.toString()
                         ,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryButtonColor2,
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

