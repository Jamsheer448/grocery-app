// import 'package:flutter/material.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/provider/sharedprefernce.dart';
// import 'package:main_live_project/screens/createaccount.dart';
// import 'package:main_live_project/screens/homepage.dart';
// import 'package:phone_email_auth/phone_email_auth.dart';
// import 'package:provider/provider.dart';

// class PhoneSignInScreen extends StatefulWidget {
//   @override
//   State<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
// }

// class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
//   String userAccessToken = "";
//   String jwtUserToken = "";
//   bool hasUserLogin = false;
//   PhoneEmailUserModel? phoneEmailUserModel;
//   final phoneEmail = PhoneEmail();

//   @override
//   Widget build(BuildContext context) {
//     final vm = Provider.of<CommonViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink[100],
//         title: Center(child: Text('Phone Sign-In')),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (hasUserLogin) ...[
//               if (phoneEmailUserModel != null) ...[
//                 Divider(
//                   thickness: 0.5,
//                   color: Colors.grey.shade400,
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text(
//                   "User Data",
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text(
//                   "Phone Number : ${phoneEmailUserModel?.countryCode} ${phoneEmailUserModel?.phoneNumber}",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//               ],
//             ],

//             /// Sign-in button
//             if (!hasUserLogin) ...[
//               Align(
//                 alignment: Alignment.center,
//                 child: PhoneLoginButton(
//                   borderRadius: 15,
//                   buttonColor: Colors.green,
//                   label: 'Sign in with Phone Number',
//                   onSuccess: (String accessToken, String jwtToken) async {
//                     if (accessToken.isNotEmpty) {
//                       setState(() {
//                         userAccessToken = accessToken;
//                         jwtUserToken = jwtToken;
//                         hasUserLogin = true;
//                       });

//                       PhoneEmail.getUserInfo(
//                         accessToken: userAccessToken,
//                         clientId: phoneEmail.clientId,
//                         onSuccess: (userData) {
//                           setState(() {
//                             phoneEmailUserModel = userData;
//                             var countryCode = phoneEmailUserModel?.countryCode;
//                             var phoneNumber = phoneEmailUserModel?.phoneNumber;
//                             debugPrint("countryCode :: $countryCode");
//                             debugPrint("phoneNumber :: $phoneNumber");

//                             _handleSignIn(context, vm, phoneNumber!);
//                           });
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//             const SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _handleSignIn(BuildContext context, CommonViewModel vm, String phoneNumber) async {
//     await vm.duplicate_user(phoneNumber);
//     if (vm.response?.msgx == "success") {
//       await Store.setLoggedIn("yes");
//       await Store.setUsername(phoneNumber);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(),
//         ),
//       );
//     } else if (vm.response?.msgx == "failed") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Createaccountpage(
//             phoneNumber: phoneNumber,
//           ),
//         ),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/screens/createaccount.dart';
import 'package:main_project/screens/homepage.dart';
import 'package:phone_email_auth/phone_email_auth.dart';
import 'package:provider/provider.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  State<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  String userAccessToken = "";
  String jwtUserToken = "";
  bool hasUserLogin = false;
  PhoneEmailUserModel? phoneEmailUserModel;
  final phoneEmail = PhoneEmail();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Center(child: Text('Phone Sign-In')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasUserLogin && phoneEmailUserModel != null)
              FutureBuilder<void>(
                future: _handleSignIn(context, vm, phoneEmailUserModel!.phoneNumber!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return SizedBox.shrink(); // Empty widget
                  }
                },
              ),
            
            /// Sign-in button
            if (!hasUserLogin) ...[
              Align(
                alignment: Alignment.center,
                child: PhoneLoginButton(
                  borderRadius: 15,
                  buttonColor: Colors.green,
                  label: 'Sign in with Phone Number',
                  onSuccess: (String accessToken, String jwtToken) async {
                    if (accessToken.isNotEmpty) {
                      setState(() {
                        userAccessToken = accessToken;
                        jwtUserToken = jwtToken;
                        hasUserLogin = true;
                      });

                      PhoneEmail.getUserInfo(
                        accessToken: userAccessToken,
                        clientId: phoneEmail.clientId,
                        onSuccess: (userData) {
                          setState(() {
                            phoneEmailUserModel = userData;
                            debugPrint("countryCode :: ${phoneEmailUserModel?.countryCode}");
                            debugPrint("phoneNumber :: ${phoneEmailUserModel?.phoneNumber}");
                          });
                        },
                      );
                    }
                  },
                ),
              ),
            ],
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext context, CommonViewModel vm, String phoneNumber) async {
    await vm.duplicate_user(phoneNumber);
    if (vm.response?.msgx == "success") {
      await Store.setLoggedIn("yes");
      await Store.setUsername(phoneNumber);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (vm.response?.msgx == "failed") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Createaccountpage(
            phoneNumber: phoneNumber,
          ),
        ),
      );
    }
  }
}

