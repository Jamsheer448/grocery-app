import 'package:flutter/material.dart';
import 'package:main_project/model/popularmodel.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:provider/provider.dart';

Future<dynamic> alertdialog(BuildContext context, TextEditingController _textFieldController, PopulaR product) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter Quantity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textFieldController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Quantity",
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    ' Kg',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      String newQuantity = _textFieldController.text;
                      int parsedQuantity = int.tryParse(newQuantity) ?? 1;
                      if (parsedQuantity > 0) {
                        Provider.of<CartProvider>(context, listen: false).updateQuantity(product, parsedQuantity);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
