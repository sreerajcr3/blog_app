// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app/screens/Screens/Loginpage.dart';
import 'package:blog_app/screens/model/useridModel.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: HeadingWithIcon(),
        title: heading(),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
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
                  child: Title(color: Colors.white, child: Text('Name')),
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
                      color: Colors.white, child: Text('Username or email id')),
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
                  child: Title(color: Colors.white, child: Text('Password')),
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
                      saveUserId();
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
    );
  }

  saveUserId() {
    _key.currentState!.validate();
    final id = userid(
        name: _nameController.text,
        username: _usernameController.text,
        password: _passwordController.text);
    if (id.name.isNotEmpty &&
        id.username.isNotEmpty &&
        id.password.isNotEmpty) {
      userId.add(id);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }

    _nameController.clear();
    _usernameController.clear();
    _passwordController.clear();
  }
  

}
