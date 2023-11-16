import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  final int? index;
  const Favorites({this.index, super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Box favoriteBox;
  late Box userId;
  int? indx;
  bool isbox = false;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorite');
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = userId.getAt(indx!);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: HeadingWithIcon(),
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Apptext(words: 'Favorite List of ${user.name}'),
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteBox.length,
              itemBuilder: (ctx, index) {
                final blog = favoriteBox.getAt(index);

                debugPrint("A=$indx");

                if (blog.userIndex == indx) {
                  debugPrint('userindex:${blog.userIndex.toString()}');
                  debugPrint(blog.title);
                  // debugPrint(blog.imagePath.toString());
                  return ListTile(
                    title: Text(
                      blog.title,
                      style: TextStyle(color: Colors.white),
                    ),
                      leading: CircleAvatar(child: blog.imagePath,)
                  );
                }
                return Container(
                  color: Colors.grey,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<int> userIndexIdentification() async {
    debugPrint('f:widget.index: ${widget.index}');
    final sharedprefsUser = await SharedPreferences.getInstance();
    final u = sharedprefsUser.getInt('userindex');
    debugPrint('sharedprefsuserindex : $u');
    return u!;
  }
}
