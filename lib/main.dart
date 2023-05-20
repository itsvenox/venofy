// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venofy/Pages/SecondaryPages/tst.dart';
import 'package:venofy/SERVICES_Screens/MainScreen.dart';
import 'package:venofy/SERVICES_Screens/RegisterScreen.dart';
import 'package:venofy/constants.dart';
import 'SERVICES_Screens/LoginScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VENOFY',
      theme: ThemeData(
        accentColor: xsc,
        // textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme)
        textTheme: GoogleFonts.ptSansTextTheme(Theme.of(context).textTheme)
      ),
      initialRoute: FirebaseAuth.instance.currentUser != null ? "/main" : "/register",
      routes: {
        "/" :(context) => LoginScreen(),
        "/register" :(context) => RegisterScreen(),
        "/main" :(context) => MainScreen(),
        "/TST" :(context) => TST_SCR()
      }
    );
  }
}
