import 'package:flutter/material.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/provider/sharedprefernce.dart';
// import 'package:main_live_project/provider/providers.dart';
import 'package:main_project/screens/createaccount.dart';
import 'package:main_project/screens/homepage.dart';
// import 'package:main_live_project/webservice/webservice.dart';
// import 'package:main_live_project/screens/homepage.dart';
import 'package:main_project/widgets/buttonwidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  OtpScreen({required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70, left: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter the verification code we just sent to your phone number.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: PinCodeTextField(
                      appContext: context, // Pass the app context here
                      length: 6,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: Colors.black,
                        inactiveColor: Colors.red,
                      ),
                      onChanged: (value) {
                        // Add your onChanged logic here
                      },
                      onCompleted: (value) {
                        // Add your onCompleted logic here
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ButtonWidget(
                    textx: 'VERIFY',
                    onPressed: () async {
                      // Validate OTP here

                      // Example of accessing the phone number passed to the widget
                      String phoneNumber = widget.phoneNumber;
                      print('Phone number received: $phoneNumber');
                        // Call the duplicate_user method from CommonViewModel
                       vm.duplicate_user(widget.phoneNumber)
                                  .then((value) {
                                // loading = false;
                                if (vm.response!.msgx == "success") {
                                  Store.setLoggedIn("yes");
                                  Store.setUsername(widget.phoneNumber);
                                  // vm!.get_userdata(widget.phone);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return HomePage();
                                    },
                                  ));
                                } else if (vm!.response!.msgx == "failed") {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return Createaccountpage(
                                        phoneNumber: widget.phoneNumber,
                                      );
                                    },
                                  ));
                                }
                              });
                    },
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Resend OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
