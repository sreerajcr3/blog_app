import 'package:blog_app/screens/model/useridModel.dart';
import 'package:hive_flutter/adapters.dart';
part 'comment_model.g.dart';


@HiveType(typeId: 3)
class Comment extends HiveObject {
  @HiveField(0)
  final String comment;

  @HiveField(1)
  final userid user;

  @HiveField(2)
  final int blogid;
  String get name => user.name ?? 'Unknown';
  Comment({required this.comment, required this.user, required this.blogid});
}
