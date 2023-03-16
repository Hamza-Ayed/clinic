import 'package:hive/hive.dart';

// part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  String email;

  @HiveField(4)
  String firstName;

  @HiveField(5)
  String lastName;

  @HiveField(6)
  String phoneNumber;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}
