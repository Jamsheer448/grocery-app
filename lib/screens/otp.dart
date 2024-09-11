import 'package:flutter/material.dart';
import 'package:main_project/screens/otp_screen.dart';
import 'package:main_project/widgets/buttonwidget.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign - In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Enter Your Valid Phone Number.. ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'We Will Sent You One Time Password\nOTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 120),
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            hintStyle: TextStyle(color: Colors.black45),
                            prefixIcon:
                                Icon(Icons.phone, color: Colors.black45),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ButtonWidget(
                      textx: 'GET OTP',
                      onPressed: () {
                        String phoneNumber = _phoneNumberController.text.trim();
                        if (phoneNumber.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter your phone number'),
                              duration: Duration(seconds: 9),
                            ),
                          );
                        } else if (!RegExp(r'^[0-9]{10}$')
                            .hasMatch(phoneNumber)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please enter a valid 10-digit phone number'),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                  phoneNumber:
                                      _phoneNumberController.text.trim()),
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
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}
