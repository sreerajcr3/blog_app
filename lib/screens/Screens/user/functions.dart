// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> gotoHome(
  
    _usernameController, _passwordController, context,_key) async {
      final Box userId;
      userId = Hive.box('userid');
  final username = _usernameController.text;
  final password = _passwordController.text;
  bool credentialsMatch = false;
   _key.currentState!.validate();

  for (int index = 0; index < userId.length; index++) {
    final id = userId.getAt(index);
    if (id.username == username && id.password == password) {
      // Username and password match, set the flag to true.
      credentialsMatch = true;
      identifyUserIndex(username, password, userId, context);

      break; // Exit the loop since a match is found.
    }
  }

  if (credentialsMatch) {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(savedkey, true);
  } else if (username.isEmpty || password.isEmpty) {
    // Do nothing when fields are empty
    return;
  } else {
    debugPrint('not matched');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Username and password do not match'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(20),
    ));
  }
}

Future<int?> identifyUserIndex(
    String username, String password, userId, context) async {
  bool credentialsMatch = false;
  //int? index;

  for (int i = 0; i < userId.length; i++) {
    final id = userId.getAt(i);
    if (id.username == username && id.password == password) {
      credentialsMatch = true;
      int index = i;

      final sharedprfsUser = await SharedPreferences.getInstance();
      sharedprfsUser.setInt('userindex', index);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(
           // index: index,
          ),
        ),
      );
      break;
    }
  }
  return null;
}

saveUserId(_key, _nameController, _usernameController, _passwordController,
    userId, context) {
  _key.currentState!.validate();
  final id = userid(
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text);
  if (id.name!.isNotEmpty &&
      id.username!.isNotEmpty &&
      id.password!.isNotEmpty) {
    userId.add(id);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  _nameController.clear();
  _usernameController.clear();
  _passwordController.clear();
}
