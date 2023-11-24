import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/model/comment_model.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CommentPage extends StatefulWidget {
  final int blogIndex;
  const CommentPage({super.key, required this.blogIndex});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();
  late Box CommentBox;
  late Box userId;
  int? indx;
  late userid  userrr;

  @override
  void initState() {
    super.initState();
    CommentBox = Hive.box('comment');
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          
          Expanded(
            child: Container(
              color: Colors.cyan,
              child: ValueListenableBuilder(
                valueListenable: CommentBox.listenable(),
                builder: (context, value, child) {
                  return ListView.builder(itemBuilder: (ctx, index) {
                     userrr = userId.getAt(indx??0);
                   
                  // for (int i = 0; i <10; i++) {
                    // int indexx = i;
                       final comments = CommentBox.getAt(index);
                    print('name = ${comments.name}');
                    if (widget.blogIndex == comments.blogid) {
                      
                      return ListTile(
                     // title: Text(),
                      subtitle: Text(comments.comment),
                      );
                      
                    
                    
                  }
                    return null;
                });
                },
                
              ),
            ),
          ),
          TextFormField(
            controller: _commentController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    onPressed: () {
                      final value = Comment(
                          comment: _commentController.text,
                          user: userid(userIndex: indx,name:userrr.name),
                          blogid: widget.blogIndex);
                      CommentBox.add(value);
                    },
                    icon: Icon(Icons.send))),
          )
        ],
      ),
    );
  }
}
