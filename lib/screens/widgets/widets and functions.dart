// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'package:blog_app/screens/Screens/adminpanel.dart';
import 'package:blog_app/screens/Screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget heading() {
  return Center(
    child: Padding(
      padding: EdgeInsets.only(top: 20),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
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
              'BLOG',
              style: GoogleFonts.breeSerif(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.yellow)),
            ),
          ],
        ),
      ),
    ),
  );
}

class HeadingWithIcon extends StatelessWidget {
  final int? index;
  const HeadingWithIcon({super.key,this.index});

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
                'THE ',
                style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                )),
              ),
              Text(
                'BLOG',
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
            child: InkWell(
              onLongPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AdminPanel()));
              },
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => Menu(index:index),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget Apptext({
  required String? words,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Text(
      words!,
      style: GoogleFonts.poppins(fontSize: 20),
    ),
  );
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

Future<void> signout() async {
  final sharedprefs = await SharedPreferences.getInstance();
   
  sharedprefs.clear();
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
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            trimmedtext,
            style: GoogleFonts.cabin(fontSize: 25, fontWeight: FontWeight.w700),
            strutStyle: StrutStyle(height: 2.5),
          )),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final bool trimmed;
  final String words;
  final int?maxLines;
  final bool? softwrap;
  final TextOverflow? overflow;
  const DescriptionText({super.key, required this.words, this.trimmed = false, this.maxLines,  this.softwrap,  this.overflow});

  @override
  Widget build(BuildContext context) {
    final trimmedTest = trimmed ? words.trim() : words;
    return Padding(
      padding: const EdgeInsets.only(left: 9,right: 9,bottom: 8),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Text(
          trimmedTest,
          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
          strutStyle: StrutStyle(height: 2),maxLines:maxLines ,softWrap: softwrap,overflow:overflow,
        ),
      ),
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
      controller: controller,
      decoration: InputDecoration(
        hintText: hintTest,
        filled: true,
        contentPadding: EdgeInsets.only(top: 10, left: 20),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
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
      controller: controller,
      decoration: InputDecoration(
        hintText: hintTest,
        filled: true,
        contentPadding: EdgeInsets.only(top: 10, left: 20),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
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
        onLongPress: onLongPress,style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          fixedSize: Size.fromWidth(200),foregroundColor: Colors.black,shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          )
        ),
        child: child,
      ),
    );
  }
}
class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
   
    return DraggableScrollableSheet(builder: ( (context, scrollController) {
      return
       ListView.builder(controller: scrollController,itemCount: 5,itemBuilder: (ctx,index){
return ListTile(
title: Text('data'),
);
       });

    }));
  }
}

// PreferredSizeWidget appbar(Index,_searchController){
//   return AppBar(
//       automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         title: HeadingWithIcon(
//           index: Index,
//         ),
//         // const Subtitle(words: 'Recent Blog posts'),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
//             child: SizedBox(
//               height: 40,
//               child: TextFormField(
//                 textAlignVertical: TextAlignVertical.center,
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   prefixIcon: Icon(Icons.search),
//                   fillColor: Colors.white,
//                   hintText: 'Search here ',
//                   hintStyle: TextStyle(),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     performSearch();
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//   );
// }
class appBar extends StatefulWidget {
  int? Index;
  TextEditingController searchController;
  void Function() performSearch;


   appBar({super.key,required this.Index,required this.searchController,required this.performSearch});

  @override
  State<appBar> createState() => _appBarState();
}

class _appBarState extends State<appBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: HeadingWithIcon(
          index: widget.Index,
        ),
        // const Subtitle(words: 'Recent Blog posts'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: widget. searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  hintText: 'Search here ',
                  hintStyle: TextStyle(),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    // performSearch();
                  });
                },
              ),
            ),
          ),
        ),
    );
  }
}



