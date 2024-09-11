import 'package:flutter/material.dart';
import 'package:main_project/const.dart';

class ButtonWidget extends StatelessWidget {
  String textx;
  final VoidCallback onPressed;
   ButtonWidget({
    required this.textx,
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
          color: primaryButtonColor2, borderRadius: BorderRadius.circular(35)),
      child: TextButton(
        onPressed:onPressed,
        child:  Text(
        textx,
        //  title.toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
