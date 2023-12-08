// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/model/comment_model.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  final int blogIndex;
  final Function(int) updatedCommentCount;
  final String blogKey;
  const CommentPage(
      {super.key,
      required this.blogIndex,
      required this.updatedCommentCount,
      required this.blogKey});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();

  late Box CommentBox;
  late Box userId;
  late Box blogBox;
  int? indx;

  late userid userrr = userid();
  bool checkUser = false;
  var commentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadData();
    CommentBox = Hive.box('comment');
    userId = Hive.box('userid');
    blogBox = Hive.box('blog');

    checkLoggedinComment(context);
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
  }

  void loadData() async {
    checkUser = await checkLoggedinMenu(context);
  }

  int getCommentCount(String blogkey) {
    int count = 0;
    for (int i = 0; i < CommentBox.length; i++) {
      final comments = CommentBox.getAt(i) as Comment;
      if (comments != null && blogkey == comments.key) {
        count++;
      }
    }
    return count;
  }

  void updateCommentCount() {
    final commentCount = getCommentCount(widget.blogKey);
    widget.updatedCommentCount(commentCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
          valueListenable: CommentBox.listenable(),
          builder: (context, value, child) {
            final commentCount = getCommentCount(widget.blogKey);
            return Text(
              'Comments $commentCount',
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: CommentBox.listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                    itemCount: CommentBox.length,
                    itemBuilder: (ctx, index) {
                      userrr = userId.getAt(indx ?? 0);
                      final comments = CommentBox.getAt(index) as Comment;
                      debugPrint('name = ${userrr.name}');

                      if (comments != null &&
                          comments.user != null &&
                          comments.user.name != null &&
                          widget.blogKey == comments.key) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: userrr != null
                                ? Column(
                                    children: [
                                      ListTile(
                                          title: Text(
                                            comments.user.name!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12),
                                          ),
                                          subtitle: Text(
                                            comments.comment,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                CommentBox.deleteAt(index);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                          leading: comments.user.profilePic !=
                                                      null &&
                                                  comments.user.profilePic!
                                                      .isNotEmpty
                                              ? CircleAvatar(
                                                  backgroundImage: FileImage(
                                                      File(comments
                                                          .user.profilePic!)),
                                                )
                                              : const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(DateFormat(
                                                  'hh:mm a         dd-MM-yyyy')
                                              .format(DateTime.parse(
                                                  comments.date))),
                                        ],
                                      ),
                                      //   Divider(color: Colors.grey,),
                                    ],
                                  )
                                : const SizedBox(
                                    child: Text('data'),
                                  ));
                      }
                      return const SizedBox.shrink();
                    });
              },
            ),
          ),
          checkUser
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _commentController,
                    decoration: InputDecoration(
                        hintText: 'Add a comment',
                        hintStyle: const TextStyle(color: Colors.white),
                        suffixIconColor: Colors.yellow,
                        suffixIcon: IconButton(
                            onPressed: () {
                              final value = Comment(
                                  comment: _commentController.text,
                                  user: userid(
                                      userIndex: indx,
                                      name: userrr.name,
                                      profilePic: userrr.profilePic),
                                  date: commentDate.toString(),
                                  key: widget.blogKey.toString());

                              if (_commentController.text.isNotEmpty) {
                                CommentBox.add(value);
                                final blog =
                                    blogBox.getAt(widget.blogIndex) as Blog;
                                    if (blog != null) {
                                        blog.commentCount ??= 0;
                                         blog.commentCount = (blog.commentCount ?? 0) + 1;
                                         updateCommentCount();
                                         blogBox.put(widget.blogIndex, blog);
                                    }
                              }
                              clear();
                            },
                            icon: const Icon(Icons.send))),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void clear() {
    _commentController.clear();
    updateCommentCount();
  }
}
