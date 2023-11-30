// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'package:blog_app/screens/Screens/Admin/adminlogin.dart';
import 'package:blog_app/screens/Screens/Blog/menu.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget heading() {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " BLOGGER'S ",
            style: GoogleFonts.breeSerif(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Colors.black)),
          ),
          Text(
            'CORNER',
            style: GoogleFonts.breeSerif(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Colors.black)),
          ),
        ],
      ),
    ),
  );
}

class HeadingWithIcon extends StatelessWidget {
  final int? index;
  const HeadingWithIcon({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                " BLOGGER'S ",
                style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                )),
              ),
              Text(
                'CORNER',
                style: GoogleFonts.breeSerif(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.yellow),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Menu(index: index),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                )),
          ),
        ],
      ),
    );
  }
}

// Widget Apptext({
//   required String words,
// }) {
//     final trimmedtext = words.trim();
//    final word =trimmedtext.isNotEmpty? trimmedtext[0].toUpperCase()+trimmedtext.substring(1):trimmedtext;
//   return Padding(
//     padding: const EdgeInsets.all(15.0),
  
//     child: Text(
//       word,
//       style: GoogleFonts.poppins(fontSize: 20),
//     ),
//   );
// }


class Apptext extends StatelessWidget {
  final String words;
  final bool trimmed;
  const Apptext({super.key, required this.words, this.trimmed = false});

  @override
  Widget build(BuildContext context) {
    final trimmedtext = trimmed ? words.trim() : words;
    final word = trimmedtext.isNotEmpty
        ? trimmedtext[0].toUpperCase() + trimmedtext.substring(1)
        : trimmedtext;
    return Padding(
      padding: const EdgeInsets.only(left: 19, top: 10, bottom: 15),
      child: Text(
        word,
       style: GoogleFonts.poppins(fontSize: 20),
     
      ),
    );
  }
}




class AppText extends StatelessWidget {
  final String words;
  final void Function() action;
  const AppText({super.key, required this.words, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Text(
        words,
        style: GoogleFonts.poppins(fontSize: 20),
      ),
    );
  }
}



class Subtitle extends StatelessWidget {
  final String words;
  const Subtitle({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        words,
        style: GoogleFonts.kanit(color: Colors.yellow, fontSize: 20),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String words;
  final bool trimmed;
  const TitleText({super.key, required this.words, this.trimmed = false});

  @override
  Widget build(BuildContext context) {
    final trimmedtext = trimmed ? words.trim() : words;
    final word = trimmedtext.isNotEmpty
        ? trimmedtext[0].toUpperCase() + trimmedtext.substring(1)
        : trimmedtext;
    return Padding(
      padding: const EdgeInsets.only(left: 19, top: 10, bottom: 15),
      child: Text(
        word,
        style: GoogleFonts.cabin(fontSize: 25, fontWeight: FontWeight.w700),
        strutStyle: StrutStyle(height: 2.5),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final bool trimmed;
  final String words;
  final int? maxLines;
  final bool? softwrap;
  final TextOverflow? overflow;
  const DescriptionText(
      {super.key,
      required this.words,
      this.trimmed = false,
      this.maxLines,
      this.softwrap,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    final trimmedTest = trimmed ? words.trim() : words;
    final word = trimmedTest.isNotEmpty
        ? trimmedTest[0].toUpperCase() + trimmedTest.substring(1)
        : trimmedTest;
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 19, right: 9, bottom: 8),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                word,
                style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w500),
                strutStyle: StrutStyle(height: 2),
                maxLines: maxLines,
                softWrap: softwrap,
                overflow: overflow,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class footerText extends StatelessWidget {
  //final Color color;
  final String words;
  const footerText({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        words,
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({super.key});

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  List<String> Categories = ['A', 'B', 'D'];
  //String? _selectedcategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButton<String>(
          items: <String>['A', 'B', 'C'].map((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {}),
    );
  }
}

class testformfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintTest;
  String? Function(String?)? validator;

  testformfield(
      {super.key,
      required this.controller,
      required this.hintTest,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintTest,
        filled: true,
        contentPadding: EdgeInsets.only(top: 10, left: 20),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

class PasswordTestformfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintTest;
  String? Function(String?)? validator;
  final bool obscuretext;

  PasswordTestformfield(
      {super.key,
      required this.controller,
      required this.hintTest,
      required this.validator,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintTest,
        filled: true,
        contentPadding: EdgeInsets.only(top: 10, left: 20),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      obscureText: obscuretext,
    );
  }
}

class Button extends StatelessWidget {
  void Function() onPressed;
  void Function() onLongPress;
  final Widget child;

  Button(
      {super.key,
      required this.child,
      required this.onLongPress,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            fixedSize: Size.fromWidth(200),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: child,
      ),
    );
  }
}



class AppbarContainer extends StatelessWidget {
  const AppbarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 7,
          decoration: const BoxDecoration(
              color:
                  // Color(0xFFC7D9E7),
                  Colors.yellow,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(80))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              heading(),
            ],
          ),
        ),
        Positioned(
            left: 10,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                weight: 5.0,
              ),
            )),
        Positioned(
          top: 30,
          right: 20,
          child: InkWell(
            onLongPress: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => AdminLogin())),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Menu()));
                },
                color: Colors.black,
                icon: Icon(Icons.menu)),
          ),
        )
      ],
    );
  }
}

descriptionfield(descriptionController, Description) {
  return TextFormField(
    minLines: 3,
    maxLines: 5,
    controller: descriptionController,
    validator: (value) {
      if (value!.isEmpty) {
        return "Description required";
      }
      return null;
    },
    onSaved: (newValue) {
      Description = newValue;
    },
    decoration: InputDecoration(
      hintText: 'Enter the description......',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
