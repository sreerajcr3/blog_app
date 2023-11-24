import 'dart:io';

import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/Screens/Blog/editPage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  late Box blogBox;
  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: heading(),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: blogBox.length,
                itemBuilder: (context, index) {
                  final blog = blogBox.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>BlogPage(blog: blog)));
                      },
                      child: ListTile(
                        title: Text(
                          blog.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: FileImage(File(blog.imagePath)),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> 
                                                                  EditPage(
                                                                selectedDate:
                                                                    blog.date,
                                                                title: blog.title,
                                                                description: blog
                                                                    .description,
                                                                image: blog
                                                                    .imagePath,
                                                                blog: blog,
                                                                index: index,
                                                              ),));
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
