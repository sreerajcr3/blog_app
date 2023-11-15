import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Favorites extends StatefulWidget {
  final int? index;
  const Favorites({this.index, super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Box favoriteBox;
  late Box userId;
  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorite');
    userId = Hive.box('userid');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: heading(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteBox.length,
              itemBuilder: (ctx, index) {
                final blog = favoriteBox.getAt(index) ;
                // for (int i = 0; i < favoriteBox.length; i++) {
                //  Blog.userIndex = i;
      final id = favoriteBox.getAt(index);
              //  final currentIndex = index;
                if (widget.index == id.userIndex) {
                  f();
                  return ListTile(title: Text(blog.title));
                   }
               // }
              },
            ),
          ),
        ],
      ),
    );
  }

  void f() {
    var index = 0;
    print('widget.index: ${widget.index}');
  }
}
