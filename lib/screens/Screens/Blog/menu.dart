// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/bottomnavigation.dart';
import 'package:blog_app/screens/Screens/Blog/category2.dart';
import 'package:blog_app/screens/Screens/Blog/about_us.dart';
import 'package:blog_app/screens/Screens/Blog/terms_and_condition.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/Screens/user/signup.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

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
  late Box userId;
  bool checkuser = false;
  int? indx;
  dynamic user;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    loadData();
  }

  void loadData() async {
    checkuser = await checkLoggedinMenu(context);
    // print(checkuser);
  }

  @override
  Widget build(BuildContext context) {
    checkuser == true ? user = indx != null ? userId.getAt(indx!) : null : null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
            
              SizedBox(
                height: 30,
              ),
              checkuser
                  ? Text(
                      'Hi   ${user.name}...!',
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    )
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height/5,
              ),
              Column(
                children: [
                  AppText(
                      words: 'Home',
                      action: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (ctx) => BottomBavigationBar(
                                    // index: index,
                                    )));
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  AppText(
                      words: 'Create your own Blog',
                      action: () {
                        checkLoggedinAddBlogMenu(context);
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  AppText(
                      words: 'Categories',
                      action: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => Category2()));
                      }),
                  !checkuser
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(),
                  !checkuser
                      ? AppText(
                          words: 'Sign in',
                          action: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => SignUp()));
                          })
                      : SizedBox(),
                  checkuser
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(),
                  checkuser
                      ? AppText(
                          words: 'Profile',
                          action: () {
                            checkLoggedinProfileMenu(context);
                          })
                      : SizedBox(),
                  SizedBox(
                    height: 30,
                  ),
                  checkuser
                      ? AppText(
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
                                            signout(context);
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
                                          },
                                          child: Text('ok'))
                                    ],
                                  );
                                }));
                          })
                      : AppText(
                          words: 'Log in',
                          action: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => LoginScreen()));
                          }),
                  SizedBox(
                    height: 30,
                  ),
                  AppText(
                      words: 'Privacy Policy',
                      action: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => AboutUs()));
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  AppText(
                      words: "Terms and conditions",
                      action: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => TermsAndCondition()));
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
