import 'package:hive/hive.dart';

  part 'useridModel.g.dart';

@HiveType(typeId: 1)
class userid extends HiveObject{

@HiveField(0)
final String name;

@HiveField(1)
final String username;


@HiveField(2)
final String password;

  userid({required this.name, required this.username, required this.password});


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
   bool isFavorite;

  @HiveField(1)
   int userIndex;

  favorites({this.isFavorite = false, required this.userIndex});
  
}