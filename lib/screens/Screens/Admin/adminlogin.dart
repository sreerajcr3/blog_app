
import 'package:blog_app/screens/Screens/Admin/adminpanel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppbarContainer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  AppbarContainer(child: Text('data',style: TextStyle(color: Colors.blue),),),
            const AppbarContainer(
             
            ),
            Container(
              color:Colors.yellow,
              // const Color(0xFFC7D9E7),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80))),
                height: MediaQuery.sizeOf(context).height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(child: TitleText(words: 'Admin Login')),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Username'),
                          ),
                          testformfield(
                              controller: _usernameController,
                              hintTest: 'enter username',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "username is required";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Password'),
                          ),
                          PasswordTestformfield(
                              controller: _passwordController,
                              hintTest: 'enter password',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password is required";
                                }
                                return null;
                              },
                              obscuretext: true),
                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                              child: const Text('log in'),
                              onLongPress: () {},
                              onPressed: () {
                                login();
                              })
                        ],
                      ),
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

  void login() {
    _key.currentState?.validate();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'admin' && password == '123') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const AdminPanel()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("username and password does not match"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
      ));
    }
  }
}
