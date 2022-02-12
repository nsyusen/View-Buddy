import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:view_buddy/services/movie_service.dart';
import 'package:view_buddy/services/tv_service.dart';

import 'Screens/home_page_screen.dart';

// Set up services
void setupLocator() {
  GetIt.I.registerLazySingleton(() => MovieService());
  GetIt.I.registerLazySingleton(() => TVService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Buddy',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePageScreen(),
    );
  }
}
