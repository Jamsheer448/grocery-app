import 'dart:math';

import 'package:flutter/material.dart';

// import '../Constants/const.dart';

Widget buildFruitItem(
  String imagePath,
  String fruitName,
  String price,
  String weight,
) {
  // final Color color = Colors.primaries[index % Colors.primaries.length];
  return Container(
    margin: EdgeInsets.all( 5),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              width: 130,
              height: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 7.0), // Adjusted SizedBox height
          Text(
            fruitName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]
                        .withOpacity(0.2)),
                        
                child: Text(
                  '$weight kg',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

List<Map<String, String>> fruits = [
  {
    'imagePath': 'assets/images/avocado.png',
    'fruitName': 'Avocado',
    'price': '350/-',
    'weight': '1',
  },
  {
    'imagePath': 'assets/images/pomegranate.png',
    'fruitName': 'Pomegranate',
    'price': '450/-',
    'weight': '1',
  },
  {
    'imagePath': 'assets/images/kiwi.png',
    'fruitName': 'Kiwi',
    'price': '500/-',
    'weight': '1',
  },
  {
    'imagePath': 'assets/images/banana.png',
    'fruitName': 'Banana',
    'price': '220/-',
    'weight': '1',
  },
  {
    'imagePath': 'assets/images/pasion.png',
    'fruitName': 'Passion Fruit',
    'price': '320/-',
    'weight': '1',
  },
  {
    'imagePath': 'assets/images/orange.png',
    'fruitName': 'Orange',
    'price': '450/-',
    'weight': '1',
  },
];