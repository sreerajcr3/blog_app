// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/Screens/Blog/categories.dart';
import 'package:blog_app/screens/Screens/user/signup.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Menu extends StatefulWidget {
  final int? index;
  Menu({super.key, this.index});
  final bool userLoggedIn = false;

  final Widget space = SizedBox(
    height: 20,
  );

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Box userId;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }

  // var index;

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (ctx) => HomeScreen(
                                        index: index,
                                      )));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Create your own Blog',
                        action: () {
                          checkLoggedin(context);
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Categories',
                        action: () {
                         
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (ctx) => Categories(
                                        index: widget.index,
                                      )));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Sign in',
                        action: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => SignUp()));
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
                                    TextButton(
                                        onPressed: () {
                                          signout();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Logged out succesfully'),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(20),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          LoginScreen()),
                                                  (route) => false);
                                        },
                                        child: Text('ok'))
                                  ],
                                );
                              }));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    AppText(
                        words: 'Profile',
                        action: () {
                        checkLoggedinProfile(context);
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

 

 
}
