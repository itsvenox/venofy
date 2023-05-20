// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../widgets/my_button.dart';
import 'package:palette_generator/palette_generator.dart';



class DetailsScreen extends StatefulWidget {
  final DocumentSnapshot data;

  DetailsScreen({required this.data});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;
  IconData favoriteIcon = Icons.favorite_border;
  Color favoriteColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    User user = await FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    List<dynamic> favoriteIds = userDoc['favorites'];
    if (favoriteIds.contains(widget.data.id)) {
      setState(() {
        isFavorite = true;
        favoriteIcon = Icons.favorite;
        favoriteColor = xsc;
      });
    }
  }

  void _toggleFavorite() async {
    User user = await FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    List<dynamic> favoriteIds = userDoc['favorites'];
    if (isFavorite) {
      favoriteIds.remove(widget.data.id);
      setState(() {
        isFavorite = false;
        favoriteIcon = Icons.favorite_border;
        favoriteColor = Colors.white;
      });
    } else {
      favoriteIds.insert(0, widget.data.id);
      setState(() {
        isFavorite = true;
        favoriteIcon = Icons.favorite;
        favoriteColor = xsc;
      });
    }
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .update({'favorites': favoriteIds});
  }

  @override
  Widget build(BuildContext context) {
    List<String> classify = List.from(widget.data['classify']);
    return Scaffold(
      backgroundColor: xbg,
      body: Stack(children: [
        Opacity(
          opacity: 0.4,
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(widget.data["image"], // Hire comes from FIRESTORE
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                        },
                        child: Icon(Icons.error_outline_rounded, color: Colors.white,),
                      ),
                    ])
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(108, 179, 179, 179),
                          spreadRadius: 0.3,
                          blurRadius: 25
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(widget.data["image"],
                      height: 350,
                      width: 220,
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.data["title"], // Hire COMES TITLE FROM FIRESTORE
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.ubuntu(
                              color: xtxt,
                              fontSize: 25,
                              fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                LineSpace(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Year :",
                            style: GoogleFonts.ubuntu(
                              color: xtxt,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          YearBox(data: widget.data),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text("Rate :",
                          style: GoogleFonts.ubuntu(
                              color: xtxt,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                height: 29,
                                decoration: BoxDecoration(
                                  color: xcvr,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Text(widget.data["rate"],
                                          style: GoogleFonts.ubuntu(
                                            color: xsc,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Icon(Icons.star_rate_rounded, color: xsc, size: 15,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ]
                      ),
                      // SizedBox(width: 50,),
                      
                      ]),
                ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Genres :",
                        style: GoogleFonts.ubuntu(
                          color: xtxt,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: xsc,
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: classify.length,
                          itemBuilder: (context,index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: xcvr,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                      child: Text(classify[index],
                                        style: GoogleFonts.ubuntu(
                                          color: xsc,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text("story",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.ubuntu(
                    color: xtxt,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.data["description"],
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.ubuntu(
                      color: xtxt.withOpacity(0.5),
                      fontSize: 17,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyButton(
                        title: "شاهد",
                        color: xtxt,
                        textColor: xbg,
                        onPressed:() async {
                          
                          String url = widget.data["url"];
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            splashColor: xx,
                          icon: Icon(favoriteIcon, color: favoriteColor, size: 30,),
                          onPressed: _toggleFavorite,
                          ),
                        )
                      )
                    ],
                  ),
                ),
                Text("ID : " + widget.data["id"].toString(),
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.ubuntu(
                    color: xtxt.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          )
        ),
      ]),
    );
  }
}

class YearBox extends StatelessWidget {
  const YearBox({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          color: xcvr,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(data["year"],
              style: GoogleFonts.ubuntu(
                color: xsc,
                fontSize: 15,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LineSpace extends StatelessWidget {
  const LineSpace({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          height: 1,
          color: xhtxt.withOpacity(.09),
        ),
      ),
    );
  }
}






// IconButton(
//   icon: Icon(favoriteIcon, color: favoriteColor),
//   onPressed: _toggleFavorite,
// ),


// class DetailsScreen extends StatefulWidget {
//   final DocumentSnapshot data;
//   const DetailsScreen({Key? key, required this.data}) : super(key: key);

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
  

//   @override
//   Widget build(BuildContext context) {
//     late bool isInFavorites = false;
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     String uid = _auth.currentUser!.uid;
//     String movieId = widget.data["id"].toString();
//     List<dynamic> userFavorites = [];
//     FirebaseFirestore.instance.collection("Users").doc(uid).get()
//       .then((result) {
//         userFavorites = result.data()!["favorites"];
//         if (userFavorites.contains(movieId)) {
//           setState(() async {
//             isInFavorites = true;
//             print("----- is in fav ");
//             // await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayRemove([movieId])});
//           });
//         } else {
//           setState(() async {
//             print("----- is not in fav");
//             // await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayUnion([movieId])});
//             isInFavorites = false;
//         });
//       }
//     });
//     List<String> classify = List.from(widget.data['classify']);
//     return Scaffold(
//       backgroundColor: xbg,
//       body: Stack(children: [
//         Opacity(
//           opacity: 0.4,
//           child: ShaderMask(
//             shaderCallback: (rect) {
//               return LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.black, Colors.transparent],
//               ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
//             },
//             blendMode: BlendMode.dstIn,
//             child: Image.network(widget.data["image"], // Hire comes from FIRESTORE
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           child: SafeArea(
//               child: Column(
//             children: [
//               Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(Icons.arrow_back, color: Colors.white,),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // Navigator.pop(context);
//                         },
//                         child: Icon(Icons.error_outline_rounded, color: Colors.white,),
//                       ),
//                     ],
//                   )),
//                   SizedBox(height: 40),
//                   Column(
//                     children: [
//                       Padding(padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(108, 179, 179, 179),
//                               spreadRadius: 0.3,
//                               blurRadius: 25
//                             )
//                           ]
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(30),
//                           child: Image.network(widget.data["image"],
//                           height: 350,
//                           width: 220,
//                           fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(widget.data["title"], // Hire COMES TITLE FROM FIRESTORE
//                                 overflow: TextOverflow.fade,
//                                 style: GoogleFonts.ubuntu(
//                                   color: xtxt,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w800
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     LineSpace(),
//                     SizedBox(height: 10),
//                     Column(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Year :",
//                               style: GoogleFonts.ubuntu(
//                                 color: xtxt,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             YearBox(data: widget.data),
//                           ],
//                         ),
//                         SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Text("Rate :",
//                             style: GoogleFonts.ubuntu(
//                                 color: xtxt,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Container(
//                                   height: 29,
//                                   decoration: BoxDecoration(
//                                     color: xcvr,
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(6.0),
//                                       child: Row(
//                                         children: [
//                                           Text(widget.data["rate"],
//                                             style: GoogleFonts.ubuntu(
//                                               color: xsc,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w400
//                                             ),
//                                           ),
//                                           SizedBox(width: 2),
//                                           Icon(Icons.star_rate_rounded, color: xsc, size: 15,)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ),
//                           ]
//                         ),
//                         // SizedBox(width: 50,),
                        
//                         ]),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Text("Genres :",
//                           style: GoogleFonts.ubuntu(
//                             color: xtxt,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             // color: xsc,
//                             height: 30,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: classify.length,
//                               itemBuilder: (context,index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: xcvr,
//                                       borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(6.0),
//                                         child: Center(
//                                           child: Text(classify[index],
//                                             style: GoogleFonts.ubuntu(
//                                               color: xsc,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Text("القصة : "+widget.data["description"],
//                       textDirection: TextDirection.rtl,
//                       style: GoogleFonts.ubuntu(
//                         color: xtxt.withOpacity(0.5),
//                         fontSize: 17,
//                         fontWeight: FontWeight.w400
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           MyButton(
//                             title: "شاهد",
//                             color: xtxt,
//                             textColor: xbg,
//                             onPressed:() async {
                              
//                               String url = widget.data["url"];
//                               if (await canLaunch(url)) {
//                                 await launch(url);
//                               } else {
//                                 throw 'Could not launch $url';
//                               }
//                             },
//                           ),
//                           Container(
//                               decoration: BoxDecoration(
//                                 // color: Color.fromARGB(255, 178, 84, 84),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: MaterialButton(
//                                 splashColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 onPressed: (){ },
//                                 height: 46,
//                                 child: InkWell(
//                             onTap:() async {
//                               if (!isInFavorites) {
//                                 await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayUnion([movieId])});
//                                 setState(() {
//                                   isInFavorites = true;
//                                 });
//                               } else {
//                                 await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayRemove([movieId])});
//                                 setState(() {
//                                   isInFavorites = false;
//                                 });
//                               }
//                             },
//                             child:Icon(isInFavorites 
//                                 ? Icons.favorite_rounded  : Icons.favorite_border_rounded, 
//                                 color: isInFavorites 
//                                 ? Colors.red 
//                                 : xtxt , 
//                                 size: 35,),
//                               )
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // SizedBox(height: 15),
//                     Text("ID : " + widget.data["id"].toString(),
//                       textDirection: TextDirection.rtl,
//                       style: GoogleFonts.ubuntu(
//                         color: xtxt.withOpacity(0.5),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400
//                       ),
//                     ),
//                   ],
//                 ),
//             )
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Map<String, dynamic>? Function()> getDataFromDocument(String uid) async {
//     final document = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
//     return document.data;
// }
// }

// class YearBox extends StatelessWidget {
//   const YearBox({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   final DocumentSnapshot<Object?> data;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Container(
//         height: 29,
//         decoration: BoxDecoration(
//           color: xcvr,
//           borderRadius: BorderRadius.circular(10)
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Text(data["year"],
//               style: GoogleFonts.ubuntu(
//                 color: xsc,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LineSpace extends StatelessWidget {
//   const LineSpace({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0),
//         child: Container(
//           height: 1,
//           color: xhtxt.withOpacity(.09),
//         ),
//       ),
//     );
//   }
// }









// class DetailsScreen extends StatefulWidget {
//   final QueryDocumentSnapshot data;
//   const DetailsScreen({Key? key, required this.data}) : super(key: key);

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
  
//   @override
//   Widget build(BuildContext context) {
    
//     List<dynamic> favorites;
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     String uid = _auth.currentUser!.uid;
//     String movieId = widget.data["id"].toString();
//     List getUserFavorites() {
//     favorites = FirebaseFirestore.instance
//         .collection("Users")
//         .doc(uid)
//         .get()
//         .then((value) {
//       return value.data()!["favorites"];
//     }) as List;
//     return favorites;
//   }

//     late bool isInFavorites;
//     // var userfavorites = getUserFavorites();
//     // if (userfavorites .contains(movieId)) {
//     //   setState(() {
//     //     isInFavorites = true;
//     //     });
//     //   } else {
//     //     setState(() {
//     //     isInFavorites = false;
//     //   });
//     // }
//     List<String> classify = List.from(widget.data['classify']);
//     return Scaffold(
//       backgroundColor: xbg,
//       body: Stack(children: [
//         Opacity(
//           opacity: 0.4,
//           child: ShaderMask(
//             shaderCallback: (rect) {
//               return LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.black, Colors.transparent],
//               ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
//             },
//             blendMode: BlendMode.dstIn,
//             child: Image.network(widget.data["image"], // Hire comes from FIRESTORE
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           child: SafeArea(
//               child: Column(
//             children: [
//               Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Icon(Icons.arrow_back, color: Colors.white,),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // Navigator.pop(context);
//                         },
//                         child: Icon(Icons.error_outline_rounded, color: Colors.white,),
//                       ),
//                     ],
//                   )),
//                   SizedBox(height: 40),
//                   Column(
//                     children: [
//                       Padding(padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(108, 179, 179, 179),
//                               spreadRadius: 0.3,
//                               blurRadius: 25
//                             )
//                           ]
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(30),
//                           child: Image.network(widget.data["image"],
//                           height: 350,
//                           width: 220,
//                           fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(widget.data["title"], // Hire COMES TITLE FROM FIRESTORE
//                                 overflow: TextOverflow.fade,
//                                 style: GoogleFonts.ubuntu(
//                                   color: xtxt,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w800
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     LineSpace(),
//                     SizedBox(height: 10),
//                     Column(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text("Year :",
//                               style: GoogleFonts.ubuntu(
//                                 color: xtxt,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             YearBox(data: widget.data),
//                           ],
//                         ),
//                         SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Text("Rate :",
//                             style: GoogleFonts.ubuntu(
//                                 color: xtxt,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400
//                               ),
//                             ),
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Container(
//                                   height: 29,
//                                   decoration: BoxDecoration(
//                                     color: xcvr,
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(6.0),
//                                       child: Row(
//                                         children: [
//                                           Text(widget.data["rate"],
//                                             style: GoogleFonts.ubuntu(
//                                               color: xsc,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w400
//                                             ),
//                                           ),
//                                           SizedBox(width: 2),
//                                           Icon(Icons.star_rate_rounded, color: xsc, size: 15,)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ),
//                           ]
//                         ),
//                         // SizedBox(width: 50,),
                        
//                         ]),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Text("Genres :",
//                           style: GoogleFonts.ubuntu(
//                             color: xtxt,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             // color: xsc,
//                             height: 30,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: classify.length,
//                               itemBuilder: (context,index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: xcvr,
//                                       borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(6.0),
//                                         child: Center(
//                                           child: Text(classify[index],
//                                             style: GoogleFonts.ubuntu(
//                                               color: xsc,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Text("القصة : "+widget.data["description"],
//                       textDirection: TextDirection.rtl,
//                       style: GoogleFonts.ubuntu(
//                         color: xtxt.withOpacity(0.5),
//                         fontSize: 17,
//                         fontWeight: FontWeight.w400
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           MyButton(
//                             title: "شاهد",
//                             color: xtxt,
//                             textColor: xbg,
//                             onPressed:() async {
//                               String url = widget.data["url"];
//                               if (await canLaunch(url)) {
//                                 await launch(url);
//                               } else {
//                                 throw 'Could not launch $url';
//                               }
//                             },
//                           ),
//                           Container(
//                               decoration: BoxDecoration(
//                                 // color: Color.fromARGB(255, 178, 84, 84),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: MaterialButton(
//                                 splashColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 onPressed: (){ },
//                                 height: 46,
//                                 child: InkWell(
//                             onTap:() async {
                                
//                                 // bool isInFavorites = false;
                                
//                                 if (!isInFavorites) {
//                                   await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayUnion([movieId])});
//                                   setState(() {
//                                     isInFavorites = true;
//                                   });
//                                 } else {
//                                   await FirebaseFirestore.instance.collection('Users').doc(uid).update({"favorites": FieldValue.arrayRemove([movieId])});
//                                   setState(() {
//                                     isInFavorites = false;
//                                   });
//                                 }
//                                 // child: Icon(isInFavorites ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isInFavorites ? Colors.red : xtxt); // Use the "child" variable to set the icon
//                             },
//                             // child: Icon(isInFavorites ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isInFavorites ? Colors.red : xtxt),
//                             )
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // SizedBox(height: 15),
//                     Text("ID : " + widget.data["id"].toString(),
//                       textDirection: TextDirection.rtl,
//                       style: GoogleFonts.ubuntu(
//                         color: xtxt.withOpacity(0.5),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400
//                       ),
//                     ),
//                   ],
//                 ),
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }