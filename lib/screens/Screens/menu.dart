// ignore_for_file: prefer_const_constructors

import 'package:blog_app/screens/Screens/Home.dart';
import 'package:blog_app/screens/Screens/Loginpage.dart';
import 'package:blog_app/screens/Screens/addBlog.dart';
import 'package:blog_app/screens/Screens/categories.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  Menu({super.key});
  final bool userLoggedIn = false;

  final Widget space = SizedBox(
    height: 20,
  );

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
 

 // var index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                heading(),
                SizedBox(
                  height: 130,
                ),
                Column(
                  children: [
                    AppText(
                        words: 'Home',
                        action: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => HomeScreen()));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Create your own Blog',
                        action: () {
                          checkLoggedin();
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Categories',
                        action: () {
                          var index;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => Categories(index: index,)));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Profile',
                        action: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Log out',
                        action: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text('Do you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('cancel'),
                                    ),
                                    TextButton(onPressed: (){
                                       signout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Logged out succesfully'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (ctx) => LoginScreen()),
                              (route) => false);
                                    }, child: Text('ok'))
                                  ],
                                );
                              }));
                         
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'About',
                        action: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => LoginScreen()));
                        })
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkLoggedin() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AddBlog()));
    }
  }
}
