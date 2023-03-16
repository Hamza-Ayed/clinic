import 'package:hive/hive.dart';
part 'checkdb.g.dart';

@HiveType(typeId: 0)
class ChecksHealth extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int id;
}

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String password;
  @HiveField(3)
  late String deviceName;
}
