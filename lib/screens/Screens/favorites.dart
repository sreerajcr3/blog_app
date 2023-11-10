import 'package:blog_app/screens/model/blogModel.dart';
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
  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorite');
  
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
           child: ListView.builder(itemCount:favoriteBox.length ,itemBuilder: (ctx,index){
              final blog = favoriteBox.getAt(index) as Blog;
               
              if(favoriteBox!=null){
            print('blog.userindex: ${blog.userindex}');
                  print('widget.index: ${widget.index}');
               
                 return ListTile(title: Text(blog.title));
             }
           }),
         ),
        ],
      ),
    );
  }
  void f(){
    var index =0;
      final blog = favoriteBox.getAt(index);
     print(blog.title);
  }
}