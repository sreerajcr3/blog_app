import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdminPanel extends StatefulWidget {
  
  const AdminPanel({super.key,});

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
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userId.length,
              itemBuilder: (ctx, index) {
                final id = userId.get(index);
                return ListTile(
                  // leading: const Text('data'),
                  // title: Text(id.password),
                  title: Text(
                      'name - ${id.name}   username - ${id.username}   password - ${id.password}'),
                  trailing: IconButton(
                    onPressed: () {
                        // userId.deleteAt(widget.index);
                      //  userId.deleteAt(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void display() {
    for (int index = 0; index < userId.length; index++) {
      final id = userId.get(index) as userid;
      debugPrint(id.name);
    }
  }
}
