// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venofy/DB/FakeBD.dart';
import 'package:venofy/extentions.dart';
import '../../HomeWidgets/CategorysWidgets.dart';
import '../../constants.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    late List<String> spiltEmail = user.email!.split("@");
    String username = spiltEmail[0].toTitleCase();
    return Scaffold(
      backgroundColor: xbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello $username,",
                          style: TextStyle(
                            color: xtxt,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Wanna Watch something?",
                          style: TextStyle(
                            color: xhtxt,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              child: Image.asset("assets/images/profile.png"),
                              // .network("https://media.discordapp.net/attachments/990639796646977556/1036217310530252821/2315bd19e8078b348ea48af16a98cdda.jpg"),
                              onTap: () {
                                // CHANGE IMAGE 
                              },
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              CategorysWidgets(),
            ]
          )
        )
      )
    );
  }
}
