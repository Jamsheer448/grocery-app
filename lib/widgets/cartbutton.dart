import 'package:flutter/material.dart';
import 'package:main_project/const.dart';

class cartbutton extends StatelessWidget {
  String teeext;
  final VoidCallback onPresssed; 
   cartbutton({
    super.key,
    required this.teeext,
    required this.onPresssed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 190,
        height: 55,
        decoration: BoxDecoration(
            color: primaryButtonColor2,
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          onPressed:onPresssed,
          child: Text(
            teeext,
            //  title.toString(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
