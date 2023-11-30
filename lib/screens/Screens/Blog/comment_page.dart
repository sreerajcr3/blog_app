import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/model/comment_model.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CommentPage extends StatefulWidget {
  final int blogIndex;
  const CommentPage({super.key, required this.blogIndex});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();
  // ignore: non_constant_identifier_names
  late Box CommentBox;
  late Box userId;
  int? indx;
  late userid userrr = userid();
  bool checkUser = false;

  @override
  void initState() {
    super.initState();
    loadData();
    CommentBox = Hive.box('comment');
    userId = Hive.box('userid');
    checkLoggedinComment(context);
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
  }

    void loadData() async{
    checkUser =await checkLoggedinComment(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.white),
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
                      final comments = CommentBox.getAt(index);
                      debugPrint('name = ${userrr.name}');

                      if (comments != null &&
                          comments.user != null &&
                          comments.user!.name != null &&
                          widget.blogIndex == comments.blogid) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ignore: unnecessary_null_comparison
                            child: userrr != null
                                ? ListTile(
                                    title: Text(
                                      comments.user.name!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                    subtitle: Text(
                                      comments.comment,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          CommentBox.deleteAt(index);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                    leading: comments.user.profilePic != null
                                        ? CircleAvatar(
                                            backgroundImage: FileImage(File(
                                                comments.user.profilePic!)),
                                          )
                                        : const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ))
                                : Container());
                      }
                      return const SizedBox.shrink();
                    });
              },
            ),
          ),
          checkUser?
          Padding(
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
                            blogid: widget.blogIndex);
                        CommentBox.add(value);
                        clear();
                      },
                      icon: const Icon(Icons.send))),
            ),
          ):Container()
        ],
      ),
    );
  }

  void clear() {
    _commentController.clear();
  }
}
