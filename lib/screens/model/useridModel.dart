import 'package:hive/hive.dart';

  part 'useridModel.g.dart';

@HiveType(typeId: 1)
class userid extends HiveObject{

@HiveField(0)
final String? name;

@HiveField(1)
final String? username;


@HiveField(2)
final String? password;

@HiveField(3)
final String? likedBlogs;

@HiveField(4)
final int? userIndex;


  userid( { this.userIndex,this.likedBlogs,this.name,  this.username,  this.password});


}
@HiveType(typeId: 4)
class commentData extends HiveObject{

  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String comment;

  commentData(this.userName, this.comment);
}

@HiveType(typeId: 2)
class  favorites extends HiveObject {

  @HiveField(0)
   bool isfavorite;

  @HiveField(1)
   int userIndex;

  favorites({this.isfavorite = false, required this.userIndex});
  
}