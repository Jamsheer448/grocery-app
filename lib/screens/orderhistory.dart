import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/screens/order.dart'; // Import your OrderDetails screen
import 'package:main_project/shimmer%20widgets/simmerorderhistory.dart';
import 'package:main_project/view%20model/orderhistoryviewmodel.dart';
import 'package:main_project/shimmer%20widgets/shimmercategory.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  CommonViewModel? vm;





int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
}





  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);



    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
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
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<OrderHistoryViewModel>>(
          future: vm?.getOrderHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {



              return Center(
                child: ShimmerOH(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<OrderHistoryViewModel> orderItems = snapshot.data ?? [];
              if (orderItems.isEmpty) {
                return Center(
                  child: Text('No orders',style:TextStyle( fontSize: 20),),
                );
              } else {
                return ListView.builder(
                  itemCount: orderItems.length,
                  itemBuilder: (context, index) {







int diffr=calculateDifference(DateTime.parse(orderItems[index].deliverydate));
log("sssss----"+diffr.toString());

                    
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetails(
                              orderDate: orderItems[index].orderDate,
                              orderId: orderItems[index].orderId.toString(),
                              quantity: orderItems[index].quantityy.toString(),
                              product: orderItems[index].products,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.grey.shade300,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      color: Colors.black,
                                      strokeWidth: 1,
                                      dashPattern: [10],
                                      child: Container(
                                        width: double.infinity,
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.history,
                                              size: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order id-${orderItems[index].orderId}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Delivery date- ${orderItems[index].deliverydate}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    orderItems[index].totalAmount.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
diffr<=-1?

     Text(
                                    "Delivered",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ):

diffr==0?
                                  Text(
                                    "Will be delivered today",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  )

:

diffr==1?
                                  Text(
                                    "Delivery expected by tomorrow",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ):
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),



                                ],
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
          },
        ),
      ),
    );
  }
}
