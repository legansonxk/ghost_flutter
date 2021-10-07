import 'package:flutter/material.dart';
import 'package:ghost_flutter/splash/splash.dart';
import 'package:provider/provider.dart';

import 'author/author_model.dart';
import 'home/home_model.dart';
import 'tag/tag_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeModel()),
        ChangeNotifierProvider(create: (_) => TagModel()),
        ChangeNotifierProvider(create: (_) => AuthorModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      )
    );
  }
}