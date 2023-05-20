// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainScreen.dart';
import 'package:venofy/SERVICES_Screens/RegisterScreen.dart';
import 'package:venofy/constants.dart';
import '../widgets/my_button.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  
  bool _progress = false;
  late String _email;
  late String _password;
  bool _error_ = false;
  @override
  Widget build(BuildContext context) {
    // late String _email;
    // late String _password;
    // bool _error_ = false;
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 10),
                //   child: Image.asset(
                //     "assets/images/logo.png",
                //     width: 180,
                //     height: 180,
                //   ),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                          style: TextStyle(
                            color: xtxt, fontSize: 50, fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Fill your Account Infos to Login.",
                          style: TextStyle(
                            color: xhtxt, fontSize: 16, fontWeight: FontWeight.w500
                          ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              hintText: 'Enter your Password',
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: InkWell(
                              splashColor: xx,
                              highlightColor: xx,
                              child: Text("Forget Password?",
                                style: TextStyle(
                                  color: xsc.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300
                                  )
                                ),
                              onTap: () {
                                // FORGET PASSWORD SCREEN
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyButton(
                          title: "Login",
                          color: xsc,
                          textColor: Colors.white,
                          onPressed: () async {
                            setState(() {_error_ = false;});
                            HapticFeedback.vibrate();
                            if (_email.isNotEmpty || _password.isNotEmpty) {
                              setState(() {_progress = true;});
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                                setState(() {_error_ = false;});
                                Navigator.
                                pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
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
                            // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            // await _Login(context);
                            // final emptySnackbar = SnackBar(
                            //     elevation: 6.0,
                            //       backgroundColor:  _error_ == true ? xsc : Color.fromARGB(255, 46, 129, 18),
                            //       behavior: SnackBarBehavior.floating,
                            //       content: Text( _error_ == true ? "Something went Worng !" : "Login Succsses",
                            //         style: TextStyle(color: Colors.white),
                            //       ),
                            //     );
                            // ScaffoldMessenger.of(context).showSnackBar(emptySnackbar);
                          }),
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
                                        image:
                                            AssetImage('assets/images/google.webp'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )),
                            ),
                            onTap: () { 
                              // GOOGLE LOGIN
                            },
                          ),
                          SizedBox( width:  10),
                          Text("or",
                          style: TextStyle(
                            color: xhtxt, fontWeight: FontWeight.w500
                            )
                          ),
                          SizedBox( width:  10),
                          InkWell(
                            splashColor: xx,
                            highlightColor: xx,
                            child: Text("Create new Account",
                            style: TextStyle(
                              color: xsc.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300
                              )
                            ),
                            onTap: () { 
                              // INTENT TO SIGN UP
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const RegisterScreen()));
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
  // Future<void> _Login(BuildContext context) async {
  //   if (_email.isNotEmpty && _password.isNotEmpty) {
  //     setState(() {_progress = true;});
  //     try {
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
  //       setState(() {_progress = false;});
  //     } catch (e) {
  //       setState(() {_progress = false;});
  //       print(e);
  //       _error_ = true;
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     print("Empty");
  //     _error_ = true;
  //   }
  // }
}



// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     late String _email;
//     late String _password;
//     bool _error_ = false;
//     return Scaffold(
//       backgroundColor: xbg,
//       body: SafeArea(
//           child: Container(
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 10, right: 10),
//                 //   child: Image.asset(
//                 //     "assets/images/logo.png",
//                 //     width: 180,
//                 //     height: 180,
//                 //   ),
//                 // ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8, bottom: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Login",
//                           style: TextStyle(
//                             color: xtxt, fontSize: 50, fontWeight: FontWeight.w800
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text("Fill your Account Infos to Login.",
//                           style: TextStyle(
//                             color: xhtxt, fontSize: 16, fontWeight: FontWeight.w500
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Form(
//                     child: Column(children: [
//                       TextField(
//                         style: GoogleFonts.outfit(
//                             color: Color.fromARGB(255, 150, 150, 150)),
//                         onChanged: (value) {
//                           _email = value;
//                         },
//                         maxLines: 1,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           hintStyle: GoogleFonts.outfit(
//                               color: Color.fromARGB(255, 99, 99, 99)),
//                           fillColor: xhtxt,
//                           filled: true,
//                           hintText: 'Enter your Email',
//                           prefixIcon: Icon(Icons.email,
//                               color: _error_ == false
//                                   ? xsc
//                                   : Color.fromARGB(255, 125, 47, 47)),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: _error_ == false
//                                     ? xsc
//                                     : Color.fromARGB(255, 125, 47, 47),
//                                 width: 1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextField(
//                             style: GoogleFonts.outfit(
//                                 color: Color.fromARGB(255, 150, 150, 150)),
//                             onChanged: (value) {
//                               _password = value;
//                             },
//                             maxLines: 1,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintStyle: GoogleFonts.outfit(
//                                   color: Color.fromARGB(255, 99, 99, 99)),
//                               fillColor: xhtxt,
//                               filled: true,
//                               prefixIcon: Icon(Icons.lock,
//                                   color: _error_ == false
//                                       ? xsc
//                                       : Color.fromARGB(255, 125, 47, 47)),
//                               hintText: 'Enter your Password',
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: _error_ == false
//                                         ? xsc
//                                         : Color.fromARGB(255, 125, 47, 47),
//                                     width: 1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 15, top: 5),
//                             child: InkWell(
//                               splashColor: xx,
//                               highlightColor: xx,
//                               child: Text("Forget Password?",
//                                 style: TextStyle(
//                                   color: xsc.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300
//                                   )
//                                 ),
//                               onTap: () {
//                                 // FORGET PASSWORD SCREEN
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       MyButton(
//                           title: "Login",
//                           color: xsc,
//                           textColor: Colors.white,
//                           onPressed: () async {
//                             // await _Login(context);
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Container(
//                           height: 1.4,
//                           width: 250,
//                           color: xhtxt,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             child: Container(
//                               width: 60,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Color.fromARGB(255, 24, 24, 24)),
//                               child: Center(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   height: 25.0,
//                                   width: 25.0,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image:
//                                             AssetImage('assets/images/google.webp'),
//                                         fit: BoxFit.cover),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               )),
//                             ),
//                             onTap: () { 
//                               // GOOGLE LOGIN
//                             },
//                           ),
//                           SizedBox( width:  10),
//                           Text("or",
//                           style: TextStyle(
//                             color: xhtxt, fontWeight: FontWeight.w500
//                             )
//                           ),
//                           SizedBox( width:  10),
//                           InkWell(
//                             splashColor: xx,
//                             highlightColor: xx,
//                             child: Text("Create new Account",
//                             style: TextStyle(
//                               color: xsc.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300
//                               )
//                             ),
//                             onTap: () { 
//                               // INTENT TO SIGN UP
//                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const RegisterScreen()));
//                             },
//                           ),
//                         ],
//                       )
//                     ]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
//   Future<void> _Login(BuildContext context) async {
//     if (_email.isNotEmpty && _password.isNotEmpty) {
//       setState(() {_progress = true;});
//       try {
//         await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//         // Navigator.pushNamed(context, HomeScreen.Intent);
//         setState(() {_progress = false;});
//       } catch (e) {
//         setState(() {_progress = false;});
//         print(e);
//         _error_ = true;
//       }
//     } else {
//       print("Empty");
//       _error_ = true;
//     }
//   }
// }