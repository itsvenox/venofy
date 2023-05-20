// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:venofy/constants.dart';
import '../../widgets/BigMovieWidget.dart';

import '../MainPages/DetailsScreen.dart';

class SpecificCategory extends StatelessWidget {
  final Stream<QuerySnapshot> catecory;
  final String? cateName;
  late Stream<QuerySnapshot> sCatecory =
      FirebaseFirestore.instance.collection("Movies").limit(30).snapshots();
  SpecificCategory({super.key, required this.catecory, this.cateName});
  
  

  @override
  Widget build(BuildContext context) {
    if (cateName != 'جميع الافلام') {
      sCatecory = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: cateName).limit(30).snapshots();
    }
    return Scaffold(
      backgroundColor: xbg,
      appBar: AppBar(
        backgroundColor: xbg,
        elevation: 0,
        centerTitle: true,
        title: Text(cateName!,
        style: TextStyle(
          fontSize: 20,
          color: xtxt)
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: sCatecory,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  "Error",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: xhtxt),
                );
              }
              if (!snapshot.hasData) {
                return Center(
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // number of columns
              childAspectRatio : 5.2 / 10
              // mainAxisSpacing : 400,
              // crossAxisSpacing: 200
              ),
              itemCount: data.size,
              itemBuilder: (context, index) {
                // final item = data[index];
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
              },
            );
          },
        ),
      )
    );
  }
}

// class SpecificCategoryHome extends StatelessWidget {
//   const SpecificCategoryHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }