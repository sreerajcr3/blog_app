 import 'package:blog_app/screens/model/blogModel.dart';
import 'package:hive/hive.dart';
part 'categories.g.dart';

@HiveType(typeId: 4)
 class category extends HiveObject{

  @HiveField(0)
  final Blog all;

  @HiveField(1)
  final Blog? nature;
  
  @HiveField(2)
  final Blog? science;

  @HiveField(3)
  final Blog? entertainement;

  @HiveField(4)
  final Blog? politics;

  category({required this.all,  this.nature,  this.science,  this.entertainement,  this.politics});
 }