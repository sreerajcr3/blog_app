import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/Blog/addBlog.dart';
import 'package:blog_app/screens/Screens/Blog/category2.dart';
import 'package:blog_app/screens/Screens/Blog/favorites.dart';
import 'package:blog_app/screens/Screens/user/userProfile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBavigationBar extends StatefulWidget {
  const BottomBavigationBar({super.key});

  @override
  State<BottomBavigationBar> createState() => _BottomBavigationBarState();
}

class _BottomBavigationBarState extends State<BottomBavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    const pages =[
       HomeScreen(),
       Category2(),
       AddBlog(),
       Favorites(),
       UserProfile()
    ];
    return Scaffold(
        body: pages[index],
        bottomNavigationBar: CurvedNavigationBar(
            color: Colors.yellow,
            height: 50,
            buttonBackgroundColor: Colors.yellowAccent,
            backgroundColor: Colors.black,
            animationDuration: const Duration(milliseconds: 400),
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: const [
              Icon(
                Icons.home,
                color: Colors.black,
              ),
              Icon(
                Icons.category,
                color: Colors.black,
              ),
              Icon(
                Icons.add,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              Icon(
                Icons.person,
                color: Colors.black,
              ),
            ]));
  }
}
