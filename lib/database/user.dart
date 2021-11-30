import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String username;
  @HiveField(2)
  late String profile_image;
  @HiveField(3)
  late int score;
}
