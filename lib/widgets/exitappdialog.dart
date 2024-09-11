import 'package:flutter/material.dart';

AlertDialog exitappalert(BuildContext context) {
  return AlertDialog(
// backgroundColor: Colors.black,
title: const Text(
  'Confirm Exit',
  // style: TextStyle(color: Colors.white),
),
content: const Text(
  'Are you sure you want to exit the app?',
  // style: TextStyle(color: Colors.white),
),
actionsAlignment: MainAxisAlignment.spaceBetween,
actions: [
  TextButton(
    onPressed: () {
      Navigator.pop(context, true);
    },
    child: const Text(
      'Yes',
      style: TextStyle(color: Colors.red),
    ),
  ),
  TextButton(
    onPressed: () {
      Navigator.pop(context, false);
    },
    child: const Text(
      'No',
      // style: TextStyle(color: Colors.white),
    ),
  ),
],
);}