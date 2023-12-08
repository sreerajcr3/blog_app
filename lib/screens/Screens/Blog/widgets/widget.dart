// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:blog_app/Databse/functions.dart';
import 'package:blog_app/screens/Screens/Blog/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SearchTextFormField extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController Controller;
  void Function(String) onChanged;

  SearchTextFormField(
      {super.key, required this.Controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: Controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: const Icon(Icons.search),
            fillColor: Colors.white,
            hintText: 'Search here',
            hintStyle: const TextStyle(),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

Row date(blog) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 17, top: 15),
        child: Text(
          DateFormat('d MMM y').format(
            DateTime.parse(blog.date),
          ),
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.yellow),
        ),
      ),
    ],
  );
}

Future deleteDialog(context, widget, index) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text('Do you want to delete?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel')),
          TextButton(
              onPressed: () {
                deleteBlog(widget.index);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const BottomBavigationBar(
                        // index: index,
                        )));
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('deleted succesfully'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('ok'))
        ],
      );
    }),
  );
}

class DeleteBlog extends StatelessWidget {
  const DeleteBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

deleteButton(context, index) {
 Box commentBox = Hive.box('comment');
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: const Text('Do you want to delete?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                  TextButton(
                      onPressed: () {
                        deleteBlog(index);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const BottomBavigationBar()));
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('deleted succesfully'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      child: const Text('ok'))
                ],
              );
            }));
      },
      icon: Icon(CupertinoIcons.delete_solid,size: 30,),
    ),
  );
}

editPageDescriptionfield(_descriptionController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      maxLines: null,
      minLines: 3,
      controller: _descriptionController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Description required";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

Widget editPageTitleField(_titleController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: _titleController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Title required";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

DateButton(context, selectedDate, setStateCallback) {
  return ElevatedButton(
      onPressed: () async {
        final DateTime? dateTime = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000));

        setStateCallback(() {
          selectedDate = dateTime!;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(30),
        ),
        side: const BorderSide(width: 2, color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      child: const Text('Select date'));
}
