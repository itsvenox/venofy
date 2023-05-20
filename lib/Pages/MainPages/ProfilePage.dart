// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venofy/DB/FakeBD.dart';
import 'package:venofy/Pages/SecondaryPages/tst.dart';
import 'package:venofy/Services/SignInServices.dart';
import 'package:venofy/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venofy/extentions.dart';

import '../SecondaryPages/FavoritesPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    late List<String> spiltEmail = user.email!.split("@");
    String username = spiltEmail[0];
    return Scaffold(
      backgroundColor: xbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: xhtxt.withOpacity(0.06)
                  ),
                  padding: EdgeInsets.all(20),
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username.toTitleCase() + ",",
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            
                            color: xtxt.withOpacity(.7), fontSize: 20, fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 5),
                          Text("Welcome to Venofy",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: xtxt.withOpacity(.4), fontSize: 15, fontWeight: FontWeight.w400
                          ),
                        ),
                        ],
                      ),
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          child: Image.asset("assets/images/profile.png"),
                          // .network("https://media.discordapp.net/attachments/990639796646977556/1036217310530252821/2315bd19e8078b348ea48af16a98cdda.jpg"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> TST_SCR())
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              LineSpace(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: xhtxt.withOpacity(0.06)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                    // height: 150,
                    width: double.infinity,
                    child: Personal_information(),
                  )
                ),
              ),
              LineSpace(),
              SettingsAndPrivacy(),
              LineSpace(),
              UpdatesAndDeveloper(),
              Text("version {__version__}", style: TextStyle(color: xhtxt, fontSize: 13),)
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatesAndDeveloper extends StatelessWidget {
  const UpdatesAndDeveloper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: xhtxt.withOpacity(0.06)
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          // height: 150,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("Updates & Developer Information",
                  style: TextStyle(
                    color: xsc.withOpacity(.7), fontSize: 15, fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () { },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.find_replace_outlined, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Check Update",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              LineSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async {
                    String url = 'https://www.instagram.com/xmr.py/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.instagram, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Instagram",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              LineSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async {
                    String url = 'https://github.com/itsaveno';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.github, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("github",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class SettingsAndPrivacy extends StatelessWidget {
  const SettingsAndPrivacy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: xhtxt.withOpacity(0.06)
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          // height: 150,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("Settings & Privacy",
                  style: TextStyle(
                    color: xsc.withOpacity(.7), fontSize: 15, fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () { },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.picture_in_picture_rounded, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Picture in Picture",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          height: 30,
                          width: 30,
                          child: Switch(
                            value: true, 
                            onChanged: (value) { }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LineSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>FavoritesPage())
                    );
                  },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border_rounded, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Favorate",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: xsc.withOpacity(.7))
                      ],
                    ),
                  ),
                ),
              ),
              LineSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () { },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb_outline_rounded, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Suggestion new Movie/Series",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: xsc.withOpacity(.7))
                      ],
                    ),
                  ),
                ),
              ),
              LineSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async{
                    // LOG OUT
                    // await GoogleServices().signOut();
                    await _auth.signOut();
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child:Container(
                  padding: EdgeInsets.all(3),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_outlined, size: 20, color: xsc.withOpacity(.7)),
                        SizedBox(width: 5),
                        Text("Logout",
                          style: TextStyle(
                            color: xtxt.withOpacity(.7), fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 20, color: xsc.withOpacity(.7))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class Personal_information extends StatelessWidget {
  const Personal_information({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("Personal Information",
            style: TextStyle(
              color: xsc.withOpacity(.7), fontSize: 15, fontWeight: FontWeight.w600
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () { },
            child:Container(
            padding: EdgeInsets.all(3),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 20, color: xsc.withOpacity(.7)),
                  SizedBox(width: 5),
                  Text("Email",
                    style: TextStyle(
                      color: xtxt.withOpacity(.7), fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(user.email!,
                  overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: xtxt.withOpacity(.4), fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            onTap: () { },
            child:Container(
            padding: EdgeInsets.all(3),
            child:  Row(
                children: [
                  Icon(Icons.lock, size: 20, color: xsc.withOpacity(.7)),
                  SizedBox(width: 5),
                  Text("Password",
                    style: TextStyle(
                      color: xtxt.withOpacity(.7), fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text("change Password",
                  overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: xtxt.withOpacity(.4), fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Container(
          height: .7,
          color: xhtxt.withOpacity(.06),
        ),
      ),
    );
  }
}