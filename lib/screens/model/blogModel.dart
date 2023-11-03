

import 'package:hive/hive.dart';
part 'blogModel.g.dart';

@HiveType(typeId: 0)
class Blog extends HiveObject {

 

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String date;

  Blog( {required this.date,required this.title, required this.imagePath, required this.description});
  }


