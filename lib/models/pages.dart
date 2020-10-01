import 'package:flutter/material.dart';

enum PagesName {
  Home,
  schedule,
  workshops,
  ngGirls,
  speakers,
  info,
  about,
}

class Pages {
  final PagesName name;
  final double number;

  Pages({
    @required this.name,
    @required this.number,
  });

  factory Pages.setPage({PagesName pagesName}) {
    return Pages(
      name: pagesName,
      number: pagesName.index.toDouble(),
    );
  }
}
