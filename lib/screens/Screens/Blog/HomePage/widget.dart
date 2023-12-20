import 'dart:io';

import 'package:blog_app/screens/Screens/Blog/comment_page.dart';
import 'package:blog_app/screens/Screens/Blog/editPage.dart';
import 'package:blog_app/screens/Screens/Blog/widgets/widget.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

card(blog, imagePath, indx, context, index, updatedCommentCount,
    setStateCallback, favoriteBox) {
  return Card(
    color: Colors.yellow,
    shape: const Border(
        top: BorderSide(width: 0),
        left: BorderSide(width: 0),
        right: BorderSide(width: 0),
        bottom: BorderSide(width: 0)),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: IconButton(
                        onPressed: () {
                          setStateCallback(
                            () {
                              final values = favorites(
                                  userIndex: indx ?? 0, blogIndex: index);
                              blog.isFavorite = !blog.isFavorite;

                              blog.isFavorite
                                  ? favoriteBox.add(values)
                                  : favoriteBox.deleteAt(index);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: blog.isFavorite ? Colors.red : Colors.white,
                          size: 33,
                        ),
                      ),
                    ),
                  ],
                ),
                date(blog),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TitleText(
                        words: blog.title,
                        trimmed: true,
                        softwrap: false,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    indx == blog.userIndex
                        ? IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => EditPage(
                                    selectedDate: blog.date,
                                    title: blog.title,
                                    description: blog.description,
                                    image: blog.imagePath,
                                    blog: blog,
                                    index: index,
                                    userIndex: indx!,
                                    category: blog.category!,
                                    blogkey: blog.key.toString(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.pencil,
                            ))
                        : const SizedBox(),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => CommentPage(
                                        blogIndex: index,
                                        updatedCommentCount:
                                            updatedCommentCount,
                                        blogKey: blog.key.toString(),
                                      )));
                            },
                            icon: const Icon(CupertinoIcons.chat_bubble)),
                        Text(blog.commentCount.toString()),
                      ],
                    )
                  ],
                ),
                DescriptionText(
                  trimmed: true,
                  words: blog.description,
                  softwrap: false,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
