import 'package:flutter/material.dart';
import 'package:main_project/const.dart';

class viewalll extends StatelessWidget {
  String txt;
  final VoidCallback onPressedx;
  viewalll({
    required this.txt,
    super.key,
    required this.onPressedx,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ),
          ),
          TextButton(
            onPressed: onPressedx,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
