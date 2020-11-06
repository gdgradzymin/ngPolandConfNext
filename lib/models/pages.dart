import 'package:flutter/material.dart';

class Pages {
  Pages({
    @required this.name,
  });

  factory Pages.setPage({String pagesName}) {
    return Pages(
      name: pagesName,
    );
  }

  final String name;
}
