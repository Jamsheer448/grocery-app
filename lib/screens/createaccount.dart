import 'package:flutter/material.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/screens/OTPnew.dart';
import 'package:main_project/screens/homepage.dart';
import 'package:main_project/widgets/buttonwidget.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class Createaccountpage extends StatefulWidget {
  final String phoneNumber;

  Createaccountpage({required this.phoneNumber});

  @override
  State<Createaccountpage> createState() => _CreateaccountpageState();
}

class _CreateaccountpageState extends State<Createaccountpage> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopLocationController = TextEditingController();
  final TextEditingController _NameController = TextEditingController();
  CommonViewModel? vm;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneSignInScreen(),
        ),
      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter Your Details to create account ! ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 80),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.0),
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _NameController,
                        textCapitalization:
                            TextCapitalization.words, // Capitalize each word
                        decoration: InputDecoration(
                          hintText: 'Enter Your Name',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(Icons.person, color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.0),
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _shopNameController,
                        textCapitalization:
                            TextCapitalization.words, // Capitalize each word
                        decoration: InputDecoration(
                          hintText: 'Enter Shop Name',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(Icons.store, color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.0),
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            // expands: true,
                            maxLines: 3,
                            controller: _shopLocationController,
                            textCapitalization: TextCapitalization
                                .sentences, // Capitalize the first word of each sentence
                            decoration: InputDecoration(
                              hintText: 'Enter Shop Location',
                              hintStyle: TextStyle(color: Colors.black45),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: Icon(Icons.location_on,
                                    color: Colors.black45),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ButtonWidget(
                    textx: 'SIGN UP',
                    onPressed: () async {
                      String shopName = _shopNameController.text.trim();
                      String shoplocation = _shopLocationController.text.trim();
                      String Name = _NameController.text.trim();


                        await Store.setUsername( widget.phoneNumber);

                      if (shopName.isEmpty ||
                          shoplocation.isEmpty ||
                          Name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                                child:
                                    Text('Please fill all respective fields')),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        return;
                      }

                      try {
                        Map<String, dynamic> result = await vm.createAccount(
                            widget.phoneNumber, shopName, Name, shoplocation);

                        if (result['status']) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result['msg']),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error occurred during account creation: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'An error occurred. Please try again later.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
