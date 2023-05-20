// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_const

import 'package:flutter/foundation.dart';

class FakeUser{
  late String id;
  late String email;
  late String img;

  FakeUser({
    required this.id,
    required this.email,
    required this.img,
  });


  static FakeUser users = FakeUser(
    id: "389274",
    email: "Username@example.com",
    img: "https://media.discordapp.net/attachments/990639796646977556/1036217310530252821/2315bd19e8078b348ea48af16a98cdda.jpg"
  );
}


class Movie {
  late String id;
  late String title;
  late String descrption;
  late List classify;
  late String cover;
  late List urls;
  late int year;


  Movie({
    required this.id,
    required this.title,
    required this.descrption,
    required this.classify,
    required this.cover,
    required this.urls,
    required this.year
  });


  static List<Movie> movies = [
    Movie(
      id: "id", 
      title: "Title", 
      descrption: "descrption",
      cover: "https://media.discordapp.net/attachments/990639796646977556/1036287578317521026/action-movie-poster-template-design-0f5fff6262fdefb855e3a9a3f0fdd361_screen.jpg", 
      urls: ["",""],
      classify: ["classify"], 
      year: 1230
    ),
    Movie(
      id: "id2", 
      title: "Title2", 
      descrption: "descrption2",
      cover: "https://media.discordapp.net/attachments/990639796646977556/1036287578317521026/action-movie-poster-template-design-0f5fff6262fdefb855e3a9a3f0fdd361_screen.jpg", 
      urls: ["",""],
      classify: ["classify"], 
      year: 0321
    ),
    Movie(
      id: "id2", 
      title: "Title2", 
      descrption: "descrption2",
      cover: "https://media.discordapp.net/attachments/990639796646977556/1036287578317521026/action-movie-poster-template-design-0f5fff6262fdefb855e3a9a3f0fdd361_screen.jpg", 
      urls: ["",""],
      classify: ["classify"], 
      year: 0321
    ),
    Movie(
      id: "id2", 
      title: "Title2", 
      descrption: "descrption2",
      cover: "https://media.discordapp.net/attachments/990639796646977556/1036287578317521026/action-movie-poster-template-design-0f5fff6262fdefb855e3a9a3f0fdd361_screen.jpg", 
      urls: ["",""],
      classify: ["classify"], 
      year: 0321
    ),
  ];
}
