import 'package:blog_app/screens/Screens/Admin/bloglist.dart';
import 'package:blog_app/screens/Screens/Admin/userlist.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({
    super.key,
  });

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  late Box userId;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.sizeOf(context).height / 4,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    heading(),
                   
                  ],
                )),
            Container(
              color: Colors.yellow,
              child: Container(
                height: MediaQuery.sizeOf(context).height / 1.5,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70))),
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                     const TitleText(words: 'Welcome to Admin panel'),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 20,
                      crossAxisCount: 2,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => const BlogList())),
                            child: Card(
                              color: Colors.blueAccent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.post_add, size: 70),
                                  AppText(words: 'Blogs', action: () {})
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const UserList())),
                            child: Card(
                              color: Colors.blueAccent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 70,
                                  ),
                                  AppText(words: 'Users ', action: () {})
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




//