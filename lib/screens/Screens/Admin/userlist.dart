import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
      appBar: AppBar(
        title: heading(),
        backgroundColor: Colors.transparent,
        
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userId.listenable(),
              builder: (context, value, child) {
                       return ListView.builder(
                  itemCount: userId.length,
                  itemBuilder: (context, index) {
                    final user = userId.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text('Name : ${user.name}'),
                          subtitle: Text('Username : ${user.username}'),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
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
                                                userId.deleteAt(index);
                                                signout();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('ok'))
                                        ],
                                      );
                                    });
                              
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                      ),
                    );
                  });
              },
       
            ),
          )
        ],
      ),
    );
  }
}
