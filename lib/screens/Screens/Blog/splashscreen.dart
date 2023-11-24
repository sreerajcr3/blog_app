// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THE ',
                        style: GoogleFonts.breeSerif(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        )),
                      ),
                      Text(
                        ' BLOG',
                        style: GoogleFonts.breeSerif(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 40,
                                color: Colors.yellow)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Subtitle(words: "Read."),
                        Subtitle(words: "Write."),
                        Subtitle(words: "Empower."),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => HomeScreen()));
 // checkLoggedin(context);
      
  }
 
 
}
