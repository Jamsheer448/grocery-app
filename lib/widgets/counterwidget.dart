import 'package:flutter/material.dart';
import 'package:main_project/const.dart';

class CounterWidget extends StatefulWidget {
  final Function(int) onQuantityChange; // Define the callback

  CounterWidget({required this.onQuantityChange});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              // Decrease the counter
              if (counter > 1) {
                // Ensure the counter doesn't go below 1
                counter--;
                widget.onQuantityChange(counter); // Notify the parent about the change
              }
            });
          },
          child: Container(
            height: 28,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Icon(Icons.remove, color: Colors.white, size: 10),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          '$counter Kg', // Display the counter value
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
             color: primaryButtonColor2, // You might want to define this color
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            setState(() {
              // Increase the counter
              counter++;
              widget.onQuantityChange(counter); // Notify the parent about the change
            });
          },
          child: Container(
            height: 28,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Icon(Icons.add, color: Colors.white, size: 10),
            ),
          ),
        ),
      ],
    );
  }
}
