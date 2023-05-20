// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venofy/SERVICES_Screens/LoginScreen.dart';
import 'package:venofy/Services/SignInServices.dart';
import 'package:venofy/constants.dart';

import '../widgets/my_button.dart';
import 'MainScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
  bool _progress = false;
    late String _email;
    late String _password;
    late String _confirmPassword;
    bool _error_ = false;
    return Scaffold(
      backgroundColor: xbg,
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                              color: xtxt,
                              fontSize: 50,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Make sure you use real Email.",
                          style: TextStyle(
                              color: xhtxt,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(children: [
                      TextField(
                        style: GoogleFonts.outfit(
                            color: Color.fromARGB(255, 150, 150, 150)),
                        onChanged: (value) {
                          _email = value;
                        },
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.outfit(
                              color: Color.fromARGB(255, 99, 99, 99)),
                          fillColor: xhtxt,
                          filled: true,
                          hintText: 'Enter your Email',
                          prefixIcon: Icon(Icons.email,
                              color: _error_ == false
                                  ? xsc
                                  : Color.fromARGB(255, 125, 47, 47)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _error_ == false
                                    ? xsc
                                    : Color.fromARGB(255, 125, 47, 47),
                                width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        style: GoogleFonts.outfit(
                            color: Color.fromARGB(255, 150, 150, 150)),
                        onChanged: (value) {
                          _password = value;
                        },
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.outfit(
                              color: Color.fromARGB(255, 99, 99, 99)),
                          fillColor: xhtxt,
                          filled: true,
                          prefixIcon: Icon(Icons.lock,
                              color: _error_ == false
                                  ? xsc
                                  : Color.fromARGB(255, 125, 47, 47)),
                          hintText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _error_ == false
                                    ? xsc
                                    : Color.fromARGB(255, 125, 47, 47),
                                width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        style: GoogleFonts.outfit(
                            color: Color.fromARGB(255, 150, 150, 150)),
                        onChanged: (value) {
                          _confirmPassword = value;
                        },
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.outfit(
                              color: Color.fromARGB(255, 99, 99, 99)),
                          fillColor: xhtxt,
                          filled: true,
                          prefixIcon: Icon(Icons.lock,
                              color: _error_ == false
                                  ? xsc
                                  : Color.fromARGB(255, 125, 47, 47)),
                          hintText: 'Re-enter Password ',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _error_ == false
                                    ? xsc
                                    : Color.fromARGB(255, 125, 47, 47),
                                width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyButton(
                          title: "Register",
                          color: xsc,
                          textColor: Colors.white,
                          onPressed: () async {
                            setState(() {_error_ = false;});
                            HapticFeedback.vibrate();
                            if (_email.isNotEmpty &&
                                _password.isNotEmpty &&
                                _confirmPassword.isNotEmpty &&
                                _password == _confirmPassword) {
                              setState(() {_progress = true;});
                              try {
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                                FirebaseAuth _auth = FirebaseAuth.instance;
                                String uid = _auth.currentUser!.uid;
                                _addUser(uid,_email, _password);
                                setState(() {_error_ = false;});
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
                                setState(() {_progress = false;});
                              } catch (e) {
                                HapticFeedback.vibrate();
                                setState(() {_progress = false;_error_ = true;});
                                print(e);
                                
                              }
                            } else {
                              setState(() {_progress = false;_error_ = true;});
                              HapticFeedback.vibrate();
                              print("Empty");
                            }
                          }
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 1.4,
                          width: 250,
                          color: xhtxt,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 24, 24, 24)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/google.webp'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )),
                            ),
                            onTap: () async {
                              // await signInWithGoogle();
                              // await GoogleServices().signInWithGoogle();
                            },
                          ),
                          SizedBox(width: 10),
                          Text("or",
                              style: TextStyle(
                                  color: xhtxt, fontWeight: FontWeight.w500)),
                          SizedBox(width: 10),
                          InkWell(
                            splashColor: xx,
                            highlightColor: xx,
                            child: Text("Already have Account",
                                style: TextStyle(
                                    color: xsc.withOpacity(0.6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const LoginScreen()));
                            },
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
  void _addUser(String userId, String email, String password) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
    var data = {
      'uid': userId,
      'email': email,
      'favorites': []
      // 'password': password,
    };
    await usersCollection.doc(userId).set(data);
  }
  // Future<UserCredential> signInWithGoogle() async {
  // // Trigger the authentication flow
  // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // // Obtain the auth details from the request
  // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // // Create a new credential
  // final credential = GoogleAuthProvider.credential(
  //   accessToken: googleAuth?.accessToken,
  //   idToken: googleAuth?.idToken,
  // );
  // // Once signed in, return the UserCredential
  // return await FirebaseAuth.instance.signInWithCredential(credential);
// }
}
