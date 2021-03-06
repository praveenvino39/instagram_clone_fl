import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/providers/user_provider.dart';
import 'package:socialapp/screens/add_post.dart';
import 'package:socialapp/screens/feed_screen.dart';
import 'package:socialapp/screens/login_screen.dart';
import 'package:socialapp/screens/signup_screen.dart';
import 'package:socialapp/screens/user_profile_screen.dart';
import 'package:socialapp/screens/welcome_screen.dart';

void main() async {
  Widget initialWidget;
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage _storage = FlutterSecureStorage();
  bool isLoggedin = await _storage.containsKey(key: "authToken");
  isLoggedin ? initialWidget = FeedScreen() : initialWidget = WelcomeScreen();
  runApp(MyApp(
    initialWidget: initialWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget initialWidget;
  MyApp({this.initialWidget});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF256BEE),
            unselectedWidgetColor: kPrimaryColor),
        routes: {
          "/": (context) => initialWidget,
          // "/": (context) => FeedScreen(),
          "/login": (context) => LoginScreen(),
          "/signup": (context) => SignupScreen(),
          "/profile": (context) => ProfileScreen(),
          "/home": (context) => FeedScreen(),
          "/add_post": (context) => AddPost()
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
