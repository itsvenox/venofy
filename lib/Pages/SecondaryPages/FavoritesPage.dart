// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants.dart';
import '../../widgets/BigMovieWidget.dart';
import '../MainPages/DetailsScreen.dart';




class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  
  
  Future<List<DocumentSnapshot>> _getFavorites() async {
    User user = await FirebaseAuth.instance.currentUser!;
    print(user);
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    List<dynamic> favoriteIds = userDoc['favorites'];
    List<DocumentSnapshot> favoriteMovies = [];
    for (String movieId in favoriteIds) {
      DocumentSnapshot movieDoc = await FirebaseFirestore.instance
          .collection('Movies')
          .doc(movieId)
          .get();
      favoriteMovies.add(movieDoc);
    }
    return favoriteMovies;
  }

  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xbg,
      appBar: AppBar(
        backgroundColor: xbg,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Favorites",
          style: TextStyle(fontSize: 20, color: xtxt),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          
          future: _getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              // reverse: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of columns
                  childAspectRatio: 5.2 / 10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // final item = data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                      child: BigMovieWidget(
                        title: snapshot.data![index]['title'],
                        image: snapshot.data![index]["image"],
                        rate: snapshot.data![index]["rate"],
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            DetailsScreen(data: snapshot.data![index])
                          )
                        );
                      },
                    )
                  );
                }
            );
          },
        ),
      ),
    );
  }
}

























// class FavoritesPage extends StatefulWidget {
//   @override
//   _FavoritesPageState createState() => _FavoritesPageState();
// }

// class _FavoritesPageState extends State<FavoritesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: xbg,
//       appBar: AppBar(
//         backgroundColor: xbg,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "My Favorites",
//           style: TextStyle(fontSize: 20, color: xtxt),
//         ),
//       ),
//       body: Container(
//         child: StreamBuilder(
//           stream: _subject.stream,
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text(
//                 "Error",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: 20, color: xhtxt),
//               );
//             }
//             if (!snapshot.hasData) {
//               return Center(
//                 child: Text(
//                   'No favorites added yet',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20, color: xhtxt),
//                 ),
//               );
//             }
//             // final data = snapshot.requireData;
//             if (userFavorites.isEmpty) {
//               return Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20, color: xhtxt),
//                 ),
//               );
//             }
//             if (snapshot.hasData) {
//               QuerySnapshot? querySnapshot = snapshot.data;
//               List<DocumentSnapshot> documents = querySnapshot!.docs;
//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // number of columns
//                   childAspectRatio: 5.2 / 10),
//                   itemCount: documents.length,
//                   itemBuilder: (context, index) {
//                     // final item = data[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: BigerMovieWidget(
//                         title: documents[index]['title'],
//                         image: documents[index]["image"],
//                         rate: documents[index]["rate"],
//                         onTap: () {
//                       //     Navigator.of(context).push(MaterialPageRoute(
//                       //       builder: (context)=>
//                       //       DetailsScreen(data: documents[index])
//                       //   )
//                       // );
//                     },
                    
//                   ),
//                 );
//               },
              
//             );
//             } else {
//               return CircularProgressIndicator();
//           };
//         }),
//       )
//     );
//   }
//       Future<List<DocumentSnapshot>> _getFavorites() async {
//         User user = await FirebaseAuth.instance.currentUser!;
//         print(user);
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('Users')
//             .doc(user.uid)
//             .get();
//         List<dynamic> favoriteIds = userDoc['favorites'];
//         List<DocumentSnapshot> favoriteMovies = [];
//         for (String movieId in favoriteIds) {
//           DocumentSnapshot movieDoc = await FirebaseFirestore.instance
//               .collection('Movies')
//               .doc(movieId)
//               .get();
//           favoriteMovies.add(movieDoc);
//         }
//         return favoriteMovies;
//       }
// } 


















// class FavoritesPage extends StatefulWidget {

//   FavoritesPage({super.key});

//   @override
//   State<FavoritesPage> createState() => _FavoritesPageState();
// }

// class _FavoritesPageState extends State<FavoritesPage> {
//   final _firestore = FirebaseFirestore.instance;
//   final _streamController = StreamController<QuerySnapshot>();
//   late String uid;
//   List<dynamic> userFavorites = [];

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     uid = _auth.currentUser!.uid;
//     _firestore.collection("Users").doc(uid).snapshots().listen((event) {
//       setState(() {
//         userFavorites = event.data()!['favorites'];
//       });
//       // Add the new stream to the StreamController
//       Stream<QuerySnapshot<Map<String, dynamic>>> _streamController = _firestore
//     .collection("Movies")
//     .where('id', arrayContains: userFavorites).snapshots();
//     // _streamController.add(_firestore.collection("Movies").where('id', arrayContains: userFavorites).snapshots());
//     });
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     print(userFavorites);
//     return Scaffold(
//       backgroundColor: xbg,
//       appBar: AppBar(
//         backgroundColor: xbg,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "My Favorites",
//           style: TextStyle(fontSize: 20, color: xtxt),
//         ),
//       ),
//       body: Container(
//         child: StreamBuilder<QuerySnapshot>(
//           // Use the stream from the StreamController as the source of data for the StreamBuilder
//           stream: _streamController.stream,
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text(
//                 "Error",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: 20, color: xhtxt),
//               );
//             }
//             if (!snapshot.hasData) {
//               return Center(
//                 child: Text(
//                   'Loading...',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20, color: xhtxt),
//                 ),
//               );
//             }
//             final data = snapshot.requireData;
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // number of columns
//                   childAspectRatio: 5.2 / 10),
//               itemCount: data.size,
//               itemBuilder: (context, index) {
//                 // final item = data[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: BigerMovieWidget(
//                     title: data.docs[index]["title"],
//                     image: data.docs[index]["image"],
//                     rate: data.docs[index]["rate"],
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context)=>DetailsScreen(data: data.docs[index]))
//                       );
//                     }, 
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       )
//     );
//   }
// }