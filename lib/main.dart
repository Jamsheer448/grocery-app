import 'package:flutter/material.dart';
import 'package:main_project/provider/cartprovider.dart';
import 'package:main_project/provider/sharedprefernce.dart';
import 'package:main_project/screens/homepage.dart';

import 'package:main_project/screens/splashscreenmain.dart';
import 'package:main_project/provider/providers.dart';
import 'package:phone_email_auth/phone_email_auth.dart';
// import 'package:main_live_project/screens/login.dart'; // Import your login screen widget
import 'package:provider/provider.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized(); 
   
_configureAmplify() {
}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     PhoneEmail.initializeApp(clientId: '17536288629340035643');
    //  12551844450194663237
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CommonViewModel()),
      ChangeNotifierProvider(create: (_) => CartProvider())
      
      ],
      child: FutureBuilder<String?>(
        future: Store.getLoggedIn(), // Check login status from SharedPreferences
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while checking login status
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData && snapshot.data == "yes") {
              // If user is logged in, navigate to Home Page
              return MaterialApp(
                title: 'DoorDash',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: "Montserrat",
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: HomePage(),
              );
            } else {
              // If user is not logged in or if there's no data in SharedPreferences,
              // navigate to OTP screen to verify phone number
              return MaterialApp(
                title: 'DoorDash',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: "Montserrat",
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home:  SplashScreennew(),
              );
            }
          }
        },
      ),
    );
  }
}
