import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Genre {
  int id;
  String name;
  List<Color> colors;
  IconData icon;

  Genre({
    required this.id,
    required this.name,
    required this.colors,
    required this.icon,
  });
}

List<Genre> genresList = [
  Genre(
    id: 28,
    name: "Action",
    icon: Icons.bolt,
    colors: [const Color(0xffFF512F), const Color(0xffDD2476)],
  ),
  Genre(
    id: 12,
    name: "Adventure",
    icon: Icons.explore,
    colors: [const Color(0xff12c2e9), const Color(0xffc471ed)],
  ),
  Genre(
    id: 16,
    name: "Animation",
    icon: Icons.animation,
    colors: [const Color(0xffFF8008), const Color(0xffFFC837)],
  ),
  Genre(
    id: 35,
    name: "Comedy",
    icon: Icons.sentiment_very_satisfied,
    colors: [const Color(0xfff093fb), const Color(0xfff5576c)],
  ),
  Genre(
    id: 80,
    name: "Crime",
    icon: Icons.gavel,
    colors: [const Color(0xff373B44), const Color(0xff4286f4)],
  ),
  Genre(
    id: 99,
    name: "Documentary",
    icon: Icons.menu_book,
    colors: [const Color(0xff00b09b), const Color(0xff96c93d)],
  ),
  Genre(
    id: 18,
    name: "Drama",
    icon: Icons.masks,
    colors: [const Color(0xffe65c00), const Color(0xffF9D423)],
  ),
  Genre(
    id: 10751,
    name: "Family",
    icon: Icons.family_restroom,
    colors: [const Color(0xff1D976C), const Color(0xff93F9B9)],
  ),
  Genre(
    id: 14,
    name: "Fantasy",
    icon: Icons.auto_fix_high,
    colors: [const Color(0xff833ab4), const Color(0xfffd1d1d)],
  ),
  Genre(
    id: 36,
    name: "History",
    icon: Icons.history_edu,
    colors: [const Color(0xff606c88), const Color(0xff3f4c6b)],
  ),
  Genre(
    id: 27,
    name: "Horror",
    icon: Icons.scuba_diving,
    colors: [const Color(0xff232526), const Color(0xff414345)],
  ),
  Genre(
    id: 10402,
    name: "Music",
    icon: Icons.music_note,
    colors: [const Color(0xff6a11cb), const Color(0xff2575fc)],
  ),
  Genre(
    id: 9648,
    name: "Mystery",
    icon: Icons.psychology,
    colors: [const Color(0xff485563), const Color(0xff29323c)],
  ),
  Genre(
    id: 10749,
    name: "Romance",
    icon: Icons.favorite,
    colors: [const Color(0xfff80759), const Color(0xffbc4e9c)],
  ),
  Genre(
    id: 878,
    name: "Science Fiction",
    icon: Icons.rocket_launch,
    colors: [const Color(0xff0575E6), const Color(0xff021B79)],
  ),
  Genre(
    id: 10770,
    name: "TV Movie",
    icon: Icons.tv,
    colors: [const Color(0xff56ab2f), const Color(0xffa8e063)],
  ),
  Genre(
    id: 53,
    name: "Thriller",
    icon: Icons.theater_comedy,
    colors: [const Color(0xff8E2DE2), const Color(0xff4A00E0)],
  ),
  Genre(
    id: 10752,
    name: "War",
    icon: Icons.military_tech,
    colors: [const Color(0xff403B4A), const Color(0xffE7E9BB)],
  ),
  Genre(
    id: 37, 
    name: "Western", 
    icon: Icons.agriculture,
    colors: [const Color(0xff757F9A), const Color(0xffD7DDE8)],
  ),
];
