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

  @HiveField(4)
  bool isFavorite;

  @HiveField(5)
  final int? userIndex;

  @HiveField(6)
  final String? category;

  @HiveField(7)
  final String? key;

  @HiveField(8)
   int? commentCount;

  Blog(  {
    this.isFavorite = false,
    required this.date,
    required this.title,
    required this.imagePath,
    required this.description,
    this.userIndex,
    this.category,
    this.key, 
    this.commentCount = 0,
  });
}
