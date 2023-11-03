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