import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/providers/user_provider.dart';
import 'package:socialapp/screens/user_profile_screen.dart';
import 'package:socialapp/screens/welcome_screen.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF256BEE),
            unselectedWidgetColor: kPrimaryColor),
        home: ProfileScreen(),
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
