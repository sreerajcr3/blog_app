// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:blog_app/screens/Screens/Home.dart';
import 'package:blog_app/screens/Screens/addBlog.dart';
import 'package:blog_app/screens/Screens/signup.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
 
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Box userId;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  //final bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          heading(),
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TitleText(words: 'Log in'),
                  ],
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30, left: 30, right: 30),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          onLongPress: () {},
                          onPressed: () {
                            gotoHome();
                            validate();
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
                                builder: (ctx) => HomeScreen(),
                              ),
                            );
                          },
                          child: Text('Return back to Home? Click here..!'),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: const [
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
    );
  }
Future<void> gotoHome() async {
  final username = _usernameController.text;
  final password = _passwordController.text;
  bool credentialsMatch = false;

  for (int index = 0; index < userId.length; index++) {
    final id = userId.getAt(index);
    if (id.username == username && id.password == password) {
      // Username and password match, set the flag to true.
      credentialsMatch = true;
      
      break; // Exit the loop since a match is found.
    }
  }

  if (credentialsMatch) {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(savedkey, true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => AddBlog()));
  } else if (username.isEmpty || password.isEmpty) {
    // Do nothing when fields are empty
    return;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Username and password do not match'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(20),
    ));
  }
}
Future<int?> identifyUserIndex(String username, String password) async {
  bool credentialsMatch = false;
  int? index;

  for (int i = 0; i < userId.length; i++) {
    final id = userId.getAt(i);
    if (id.username == username && id.password == password) {
      credentialsMatch = true;
      index = i;
      break;
    }
  }

  if (credentialsMatch) {
    return index;
  } else {
    return null;
  }
}

  Future<void> validate() async {
    if (_key.currentState!.validate()) {}
  }
}
