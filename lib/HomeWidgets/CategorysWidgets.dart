// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:venofy/DB/FakeBD.dart';
import 'package:venofy/constants.dart';
import 'package:venofy/widgets/MovieWidget.dart';

import '../Pages/MainPages/DetailsScreen.dart';
import '../Pages/SecondaryPages/SpecificCategory.dart';

class CategorysWidgets extends StatelessWidget {
  final Stream<QuerySnapshot> allMovies =
      FirebaseFirestore.instance.collection("Movies").limit(15).snapshots();
  final Stream<QuerySnapshot> actionMovies = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: 'اكشن').limit(10)
    .snapshots();
  final Stream<QuerySnapshot> dramaMovies = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: 'دراما').limit(10)
    .snapshots();
  final Stream<QuerySnapshot> horrorMovies = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: 'رعب').limit(10)
    .snapshots();
  final Stream<QuerySnapshot> comedyMovies = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: 'كوميدي').limit(10)
    .snapshots();
      final Stream<QuerySnapshot> animationMovies = FirebaseFirestore.instance.collection("Movies").where('classify', arrayContains: 'رسوم متحركة').limit(10)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        AllMovies(moviesCollation: allMovies),
        ActionMovies(moviesCollation: actionMovies),
        AnimationMovies(moviesCollation: animationMovies),
        HorrorMovies(moviesCollation: horrorMovies,),
        DramaMovies(moviesCollation: dramaMovies),
        ComedyMovies(moviesCollation: comedyMovies,)
      ],
    );
  }
}






class AllMovies extends StatelessWidget {
  const AllMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
            child: 
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName: 'جميع الافلام',
                            // data: moviesCollation
                            )
                          )
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "All Movies | جميع الافلام",
                            style: TextStyle(
                              color: xtxt,
                              fontSize: 18,
                            ),
                          ),
                          // Spacer(),
                          Text(
                            "See All",
                            style: TextStyle(
                              color: xhtxt,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 185,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: moviesCollation,
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
                            return Text(
                              'Loading...',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: xhtxt),
                            );
                          }
                          final data = snapshot.requireData;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              try {
                                return MovieWidget(
                                  title: data.docs[index]["title"],
                                  image: data.docs[index]["image"],
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>DetailsScreen(data: data.docs[index]))
                                    );
                                  },
                              );
                              } catch (e) {
                                print(e);
                              }
                              
                            },
                          );
                        }
                      ),
                  ),
                ],
              ),
          ),
    );
  }
}




class AnimationMovies extends StatelessWidget {
  const AnimationMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName:  'رسوم متحركة',
                        )
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Animation Movies | رسوم متحركة",
                      style: TextStyle(
                        color: xtxt,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: xhtxt,
                        fontSize: 15,
                      ),
                    ),
                  ],
                            ),
                ),
            ),
            SizedBox(height: 15),
            Container(
              height: 185,
              child: StreamBuilder<QuerySnapshot>(
                  stream: moviesCollation,
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
                      return Text(
                        'Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: xhtxt),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return MovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            },
                        );
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}


class ActionMovies extends StatelessWidget {
  const ActionMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName: "اكشن",
                        )
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Action Movies | افلام اكشن",
                      style: TextStyle(
                        color: xtxt,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: xhtxt,
                        fontSize: 15,
                      ),
                    ),
                  ],
                            ),
                ),
            ),
            SizedBox(height: 15),
            Container(
              height: 185,
              child: StreamBuilder<QuerySnapshot>(
                  stream: moviesCollation,
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
                      return Text(
                        'Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: xhtxt),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return MovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            },
                        );
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}







class DramaMovies extends StatelessWidget {
  const DramaMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName: "دراما",
                        )
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Drama Movies | افلام دراما",
                      style: TextStyle(
                        color: xtxt,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: xhtxt,
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
            ),
            SizedBox(height: 15),
            Container(
              height: 185,
              child: StreamBuilder<QuerySnapshot>(
                  stream: moviesCollation,
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
                      return Text(
                        'Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: xhtxt),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return MovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            },
                        );
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}







class HorrorMovies extends StatelessWidget {
  const HorrorMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName: "رعب",
                        )
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Horror Movies | افلام رعب",
                      style: TextStyle(
                        color: xtxt,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: xhtxt,
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
            ),
            SizedBox(height: 15),
            Container(
              height: 185,
              child: StreamBuilder<QuerySnapshot>(
                  stream: moviesCollation,
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
                      return Text(
                        'Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: xhtxt),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return MovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            },
                        );
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}







class ComedyMovies extends StatelessWidget {
  const ComedyMovies({super.key, required this.moviesCollation});
  final Stream<QuerySnapshot> moviesCollation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: 
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>SpecificCategory(catecory: moviesCollation, cateName: "كوميدي",
                        )
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Comedy Movies | افلام كوميدية",
                      style: TextStyle(
                        color: xtxt,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: xhtxt,
                        fontSize: 15,
                      ),
                    ),
                  ],
                            ),
                ),
            ),
            SizedBox(height: 15),
            Container(
              height: 185,
              child: StreamBuilder<QuerySnapshot>(
                  stream: moviesCollation,
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
                      return Text(
                        'Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: xhtxt),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return MovieWidget(
                            title: data.docs[index]["title"],
                            image: data.docs[index]["image"],
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DetailsScreen(data: data.docs[index]))
                              );
                            },
                        );
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}