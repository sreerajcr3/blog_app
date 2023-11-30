// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app/Databse/functions.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late Box userId;
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();
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
              height: MediaQuery.of(context).size.height,
              color: Colors.yellow,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            TitleText(words: 'Sign up'),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child:
                              Title(color: Colors.white, child: Text('Name')),
                        ),
                        testformfield(
                          controller: _nameController,
                          hintTest: 'enter your name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: Title(
                              color: Colors.white,
                              child: Text('Username or email id')),
                        ),
                        testformfield(
                          controller: _usernameController,
                          hintTest: 'enter your username',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'username is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 5),
                          child: Title(
                              color: Colors.white, child: Text('Password')),
                        ),
                        PasswordTestformfield(
                          controller: _passwordController,
                          hintTest: 'enter your password',
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
                            child: Text('Sign up'),
                            onLongPress: () {},
                            onPressed: () {
                              saveUserId(
                                  _key,
                                  _nameController,
                                  _usernameController,
                                  _passwordController,
                                  context,
                                  userId);
                            }),
                        Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => LoginScreen()));
                                },
                                child: Text('Already have an account? Log in')))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
