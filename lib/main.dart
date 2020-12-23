import 'package:flutter/material.dart';
import 'package:leiturinhas/data.dart';
import 'package:leiturinhas/detail.dart';
import 'package:leiturinhas/home.dart';
import 'package:screen/screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    return MaterialApp(
      title: 'Leiturinhas',
      home: Home(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }

  ///Generate parameterized route --> e.g: detail/some book title
  generateRoute(RouteSettings settings) {
    final path = settings.name.split('/');
    final title = path[1];


    Book book = booksData.firstWhere((it) => it.title == title);
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Detail(book),
    );
  }
}


