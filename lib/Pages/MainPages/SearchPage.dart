// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venofy/extentions.dart';

import '../../constants.dart';
import '../../widgets/BigMovieWidget.dart';
import 'DetailsScreen.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Add a search controller to control the search field
  // final TextEditingController _searchController = TextEditingController();
  // Add a stream of data to hold the search 
  late Stream<QuerySnapshot> sCatecory = FirebaseFirestore.instance.collection("Movies").limit(20).snapshots();
  
  String _search = '';
  late Stream<QuerySnapshot> searchResult;

  @override
  void initState() {
    super.initState();
    // Set the initial data to all movies
  }

  void getSearch(String _search){
    setState(() {
      searchResult = FirebaseFirestore.instance.collection("Movies").where("title" , isGreaterThanOrEqualTo: _search.capitalize()).limit(15).snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xbg,
      appBar: AppBar(
        automaticallyImplyLeading : false,
        backgroundColor: xbg,
        elevation: 0,
        centerTitle: true,
        title: const Text("Search",
          style: TextStyle(
            fontSize: 20,
            color: xtxt
            )
          ),
      ),
      body: Container(
        child: Column(
          children: [
            // Add a search field and a search button
            Row(
              children: [
                // _searchController
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                        style: GoogleFonts.outfit(
                            color: Color.fromARGB(255, 150, 150, 150)),
                        onChanged: (value) {
                          getSearch(value);
                          _search = value;
                          },
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.outfit(
                            color: Color.fromARGB(255, 99, 99, 99)),
                          fillColor: xhtxt.withOpacity(0.13),
                          filled: true,
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search_rounded,color: xsc),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: xsc, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                  ),
                ),
              ],

            ),
            // Use the updated stream of search results to build the GridView
            StreamBuilder<QuerySnapshot>(
              stream: _search.isEmpty ? sCatecory : searchResult,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    "Error",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: xhtxt),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: xhtxt),
                    ),
                  );
                }
                final data = snapshot.requireData;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // number of columns
                        childAspectRatio: 5.2 / 10
                        // mainAxisSpacing : 400,
                        // crossAxisSpacing: 200
                        ),
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                          child: BigMovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            rate: data.docs[index]["rate"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            }, 
                          ),
                        );
                      // if (_search.isEmpty) {
                      //   return Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                      //     child: BigMovieWidget(
                      //       title: data.docs[index]["title"],
                      //       image: data.docs[index]["image"],
                      //       rate: data.docs[index]["rate"],
                      //       onTap: () {
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context)=>DetailsScreen(data: data.docs[index]))
                      //         );
                      //       }, 
                      //     ),
                      //   );
                      // }else if (data.docs[index]["title"].toString().toLowerCase().contains(_search.toLowerCase())) {
                      //   return Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                      //     child: BigMovieWidget(
                      //       title: data.docs[index]["title"],
                      //       image: data.docs[index]["image"],
                      //       rate: data.docs[index]["rate"],
                      //       onTap: () {
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context)=>DetailsScreen(data: data.docs[index]))
                      //         );
                      //       }, 
                      //     ),
                      //   );
                      // } return Container();
                  },
                  ),
                );
            },
          ),
          ]
      )
      )
    );
  }
}










// class SpecificCategory extends StatelessWidget {
//   final Stream<QuerySnapshot> catecory;
//   final String? cateName;
//   late Stream<QuerySnapshot> sCatecory =
//       FirebaseFirestore.instance.collection("Movies").snapshots();
//   SpecificCategory({super.key, required this.catecory, this.cateName});
  
  

//   @override
//   Widget build(BuildContext context) {
//     if (cateName != 'جميع الافلام') {
//       sCatecory = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: cateName).snapshots();
//     }
//     return Scaffold(
//       backgroundColor: xbg,
//       appBar: AppBar(
//         backgroundColor: xbg,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(cateName!,
//         style: TextStyle(
//           fontSize: 20,
//           color: xtxt)
//         ),
//       ),
//       body: Container(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: sCatecory,
//             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text(
//                   "Error",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: xhtxt),
//                 );
//               }
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: Text(
//                     'Loading...',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: xhtxt),
//                   ),
//                 );
//               }
//             final data = snapshot.requireData;
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, // number of columns
//               childAspectRatio : 5.2 / 10
//               // mainAxisSpacing : 400,
//               // crossAxisSpacing: 200
//               ),
//               itemCount: data.size,
//               itemBuilder: (context, index) {
//                 // final item = data[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
//                   child: BigMovieWidget(
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