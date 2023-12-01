
// ignore_for_file: prefer_const_constructors

import 'package:blog_app/screens/Screens/Blog/splashscreen.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/model/categories.dart';
import 'package:blog_app/screens/model/comment_model.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('Hive_db');
  Hive.registerAdapter<Blog>(BlogAdapter());
  Hive.registerAdapter(useridAdapter());
  Hive.registerAdapter(favoritesAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(categoryAdapter());
  
  await Hive.openBox('blog');
  await Hive.openBox('nature');
  await Hive.openBox('science');
  await Hive.openBox('entertainment');
  await Hive.openBox('politics');
  await Hive.openBox('userid');
  await Hive.openBox('favorite');
  await Hive.openBox('comment'); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // fontFamily: ,
          primaryIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          )),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
