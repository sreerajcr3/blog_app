// ignore: file_names
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable

import 'package:blog_app/screens/Screens/Admin/adminlogin.dart';
import 'package:blog_app/screens/Screens/Blog/bottomnavigation.dart';
import 'package:blog_app/screens/Screens/user/functions.dart';
import 'package:blog_app/screens/Screens/user/signup.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const savedkey = 'userLoggedin';
int? userindex;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Box userId;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  //final bool userLoggedIn = false;
  int index1 = 0;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppbarContainer(),
            Container(
              color: Colors.yellow,
              //Color(0xFFC7D9E7),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 30, left: 30, right: 30),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: TitleText(words: 'Log in')),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 8),
                          child: const Text(
                            'Username',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        testformfield(
                            controller: _usernameController,
                            hintTest: 'Enter your username',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'username is required';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 8),
                          child: Text(
                            'Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        PasswordTestformfield(
                          controller: _passwordController,
                          hintTest: 'Enter your password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                          obscuretext: true,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Button(
                            child: Text('Log in'),
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => AdminLogin()));
                            },
                            onPressed: () {
                              gotoHome(_usernameController, _passwordController,
                                  context, _key);
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => SignUp(),
                                ),
                              );
                            },
                            child: Text('Create an account? Sign up'),
                          ),
                        ),
                        Align(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => BottomBavigationBar(
                                      //  index: index1,
                                      ),
                                ),
                              );
                            },
                            child: Text('Return back to Home? Click here..!'),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: const Column(
                              children: [
                                footerText(
                                    words: 'Copyright © owned by Sreeraj CR'),
                                footerText(words: 'Privacy Policies')
                              ],
                            ),
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
