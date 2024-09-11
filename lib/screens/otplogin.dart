// ignore_for_file: deprecated_member_use

import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_project/const.dart';
import 'package:main_project/provider/providers.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/screens/createaccount.dart';
import 'package:main_project/screens/homepage.dart';

import 'package:phone_email_auth/phone_email_auth.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class AuthScreen1 extends StatefulWidget {
  const AuthScreen1({super.key});

  @override
  State<AuthScreen1> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen1> {
  final GlobalKey webViewKey = GlobalKey();

  /// InAppWebView Controller
  InAppWebViewController? webViewController;
  InAppWebViewSettings? initialSettings;

  /// Initial Authentication URL
  late String authenticationUrl;
  PhoneEmailUserModel? phoneEmailUserModel;
  final phoneEmail = PhoneEmail();

  /// Unique device token
  String? deviceId;
  // client id
  String clientid = "";
  bool loading = false;
  bool loading22 = true;
  bool loading33 = false;
  @override
  void initState() {
   // _getDeviceID();
    super.initState();

    inappvwebbb();
  }

  Widget inappvwebbb() {
    return InAppWebView(
      key: webViewKey,
      initialSettings: initialSettings = InAppWebViewSettings(
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        cacheEnabled: true,
        allowsInlineMediaPlayback: true,
      ),
      onWebViewCreated: (controller) async {
        log("aaaaa");
        webViewController = controller;
        setState(() {
          loading22 = false;
        });
        inAppWebViewConfiguration(controller);
      },
      onLoadStart: (controller, url) {
        log("startedddddd");
        setState(() {
          loading22 = true;
        });
        webViewController!.addJavaScriptHandler(
          handlerName: AppConstant.sendTokenToApp,
          callback: (arguments) {
            // log("Success Data :: $arguments");
            // log("controller :: " + controller.toString());
            // log("url :: $url");

            /// Get access token from JS and pop back to main screen
            // print("arguments.first ==== " +
            //     arguments.first.runtimeType.toString());
            log("token === " + arguments[0]["access_token"].toString());
            PhoneEmail.getUserInfo(
              accessToken: arguments[0]["access_token"].toString(),
              clientId: phoneEmail.clientId,
              onSuccess: (userData) {
                setState(() {
                  phoneEmailUserModel = userData;
                  var countryCode = phoneEmailUserModel?.countryCode;
                  var phoneNumber = phoneEmailUserModel?.phoneNumber;
                  log("countryCode :: $countryCode");
                  log("phoneNumber :: $phoneNumber");
                  vm = Provider.of<CommonViewModel>(context, listen: false);
                  vm!
                      .duplicate_user(phoneNumber.toString(),)
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                    if (vm!.response!.msgx == "success") {
                      Store.setLoggedIn("yes");
                      Store.setUsername(phoneNumber.toString());
                   
                      log("Login success");
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    } else if (vm!.response!.msgx == "failed") {
                      log("login failed");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Createaccountpage(phoneNumber: phoneNumber.toString());
                        },
                      ));

                    }
                  });
                });
              },
            );
          },
        );
      },
      onReceivedError: (controller, request, error) {
        print("Error ============>>>>>${error.description}");
        Navigator.pop(context);
      },
      onLoadStop: (controller, url) async {
        log("loadededdd");
        setState(() {
          loading22 = false;

          /// _statusMessage = "Page loaded successfully";
        });
      },
    );
  }

  Future<void> inAppWebViewConfiguration(
      InAppWebViewController controller) async {
    final _phoneEmail = PhoneEmail();

    /// Build authentication url with registered details
    authenticationUrl = "${AppConstant.authUrl}?" +
        "${AppConstant.clientId}=${_phoneEmail.clientId}" +
       // "&${AppConstant.redirectUrl}=${_phoneEmail!.redirectUrl ?? ""}" +
        "&${AppConstant.authType}=5";

    print('Authentication URL: $authenticationUrl');

    /// Load authentication url in WebView
    webViewController!.loadUrl(
      urlRequest: URLRequest(url: WebUri(authenticationUrl)),
    );
  }

  CommonViewModel? vm;
 

  //   InAppWebViewController? webViewController;

  // bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(
                fontFamily: "Quicksand",
              ),
            ),
            content: const Text(
              'Do you want to exit from DoorDash?',
              style: TextStyle(
                fontFamily: "Quicksand",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No',
                    style: TextStyle(
                        color: Colors.white10, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // Navigator.of(context).pop(true);
                },
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.red.shade900, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   toolbarHeight: 100,
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
        // ),
        body: Stack(
          children: [
            Container(
              // height: double.infinity,
              // width: double.infinity,
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            loading33
                ? CircularProgressIndicator()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                "Welcome Back",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:  Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign In your acount",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              color: Colors.white, child: inappvwebbb()),
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






// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:main_live_project/provider/providers.dart';
// import 'package:main_live_project/provider/sharedprefernce.dart';
// import 'package:main_live_project/screens/createaccount.dart';
// import 'package:main_live_project/screens/homepage.dart';
// import 'package:phone_email_auth/phone_email_auth.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';

// class Authscreen extends StatefulWidget {
//   const Authscreen({super.key});

//   @override
//   State<Authscreen> createState() => _AuthScreenState();
// }
// CommonViewModel? vm;
// class _AuthScreenState extends State<Authscreen> {
//   final GlobalKey webViewKey = GlobalKey();

//   /// InAppWebView Controller
//   InAppWebViewController? webViewController;

//   /// Initial Authentication URL
//   late String authenticationUrl;

//   String userAccessToken = "";
//   String jwtUserToken = "";
//   bool hasUserLogin = false;
//   PhoneEmailUserModel? phoneEmailUserModel;
//   final phoneEmail = PhoneEmail();
//   /// Unique device token
//   String? deviceId;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> inAppWebViewConfiguration(
//       InAppWebViewController controller) async {
//     final _phoneEmail = PhoneEmail();

//     /// Build authentication url with registered details
//     authenticationUrl = "${AppConstant.authUrl}?" +
//         "${AppConstant.clientId}=${_phoneEmail.clientId}" +
//         "&${AppConstant.redirectUrl}=${_phoneEmail.redirectUrl ?? ""}" +
//         "&${AppConstant.authType}=5";

//     print('Authentication URL: $authenticationUrl');

//     /// Load authentication url in WebView
//     webViewController!.loadUrl(
//       urlRequest: URLRequest(url: WebUri(authenticationUrl)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     vm = Provider.of<CommonViewModel>(context);
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             AppConstant.authViewTitle,
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.close_rounded),
//             color: Colors.white,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           backgroundColor: Color.fromARGB(255, 4, 201, 135),
//         ),
//         body: InAppWebView(
//           key: webViewKey,
//           initialSettings: InAppWebViewSettings(
//             javaScriptEnabled: true,
//             mediaPlaybackRequiresUserGesture: false,
//             cacheEnabled: true,
//             allowsInlineMediaPlayback: true,
//           ),
//           onWebViewCreated: (controller) async {
//             /// set webview controller
//             webViewController = controller;

//             /*
//             * Call configuration method and build auth URL
//             * */
//             inAppWebViewConfiguration(controller);
//           },
//           onLoadStart: (controller, url) {
//             /// callback method for listen response
//             webViewController!.addJavaScriptHandler(
//               handlerName: AppConstant.sendTokenToApp,
//               callback: (arguments) async{
//                 print("Success Data :: $arguments");

//                 /// Get access token from JS and pop back to main screen
//                 print(arguments.first.runtimeType);

// log("go t home ======================================================================");

//  await vm!.duplicate_user(phoneEmailUserModel?.phoneNumber);
//     if (vm.response?.msgx == "success") {
//       await Store.setLoggedIn("yes");
//       await Store.setUsername(phoneNumber);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(),
//         ),
//       );
//     } else if (vm.response?.msgx == "failed") {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Createaccountpage(
//             phoneNumber: phoneNumber,
//           ),
//         ),
//       );
//     }
                 





//               //    if (hasUserLogin && phoneEmailUserModel != null) {
//               //      FutureBuilder<void>(
//               //   future: _handleSignIn(context, vm!, phoneEmailUserModel!.phoneNumber!),
//               //   builder: (context, snapshot) {
//               //     if (snapshot.connectionState == ConnectionState.waiting) {
//               //       return Center(child: CircularProgressIndicator());
//               //     } else if (snapshot.hasError) {
//               //       return Center(child: Text('Error: ${snapshot.error}'));
//               //     } else {
//               //       return SizedBox.shrink(); // Empty widget
//               //     }
//               //   },
//               // );
//               //    }

//             //        if (!hasUserLogin) {
//             //          [
//             //   Align(
//             //     alignment: Alignment.center,
//             //     child: PhoneLoginButton(
//             //       borderRadius: 15,
//             //       buttonColor: Colors.green,
//             //       label: 'Sign in with Phone Number',
//             //       onSuccess: (String accessToken, String jwtToken) async {
//             //         if (accessToken.isNotEmpty) {
//             //           setState(() {
//             //             userAccessToken = accessToken;
//             //             jwtUserToken = jwtToken;
//             //             hasUserLogin = true;
//             //           });

//             //           PhoneEmail.getUserInfo(
//             //             accessToken: userAccessToken,
//             //             clientId: phoneEmail.clientId,
//             //             onSuccess: (userData) {
//             //               setState(() {
//             //                 phoneEmailUserModel = userData;
//             //                 debugPrint("countryCode :: ${phoneEmailUserModel?.countryCode}");
//             //                 debugPrint("phoneNumber :: ${phoneEmailUserModel?.phoneNumber}");
//             //               });
//             //             },
//             //           );
//             //         }
//             //       },
//             //     ),
//             //   ),
//             // ];
//             //        }

//                   //_handleSignIn(context, vm!, phoneEmailUserModel!.phoneNumber!);
//               },
//             );
//           },
//           onReceivedError: (controller, request, error) {
//             print("Error ============>>>>>${error.description}");
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }

//     Future<void> _handleSignIn(BuildContext context, CommonViewModel vm, String phoneNumber) async {
//     await vm.duplicate_user(phoneNumber);
//     if (vm.response?.msgx == "success") {
//       await Store.setLoggedIn("yes");
//       await Store.setUsername(phoneNumber);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(),
//         ),
//       );
//     } else if (vm.response?.msgx == "failed") {
//       Navigator.push(
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
