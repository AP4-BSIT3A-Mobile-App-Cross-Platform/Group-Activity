import 'package:flutter/material.dart';

import 'package:group_activity/views/elonmusk_view.dart';
import 'package:group_activity/views/markzucc_view.dart';
import 'package:group_activity/views/shouchew_view.dart';

class PeopleModel {
  final List<String> names;
  final List<int> ages;
  final List<String> imagePaths;
  final List<String> descriptions;
  final List<Color> themeColors;
  final List<Color> splashColors;
  final List<Widget> redirectionPage;

  PeopleModel({
    required this.names,
    required this.ages,
    required this.imagePaths,
    required this.descriptions,
    required this.themeColors,
    required this.splashColors,
    required this.redirectionPage,
  });

  static PeopleModel sampleData() {
    return PeopleModel(
      names: [
        'Mark Zuckerberg',
        'Elon Musk',
        'Shou Zi Chew',
      ],
      ages: [40, 53, 42],
      imagePaths: [
        'assets/images/markzucc.jpeg',
        'assets/images/elonmusk.JPG',
        'assets/images/shouchew.jpeg',
      ],
      descriptions: [
        'Definitely not a lizard',
        'Space dad vibes',
        'But I`m Singaporean, Senator.',
      ],
      themeColors: [
        Colors.greenAccent,
        Colors.amberAccent,
        Colors.lightBlue,
      ],
      splashColors: [
        Colors.purple,
        Colors.blueGrey,
        Colors.deepOrange,
      ],
      redirectionPage: [
        const MarkzuccView(
          index: 0,
        ),
        const ElonmuskView(
          index: 1,
        ),
        const ShouchewView(
          index: 2,
        ),
      ],
    );
  }
}
