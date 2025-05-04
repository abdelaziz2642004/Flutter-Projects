import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'Customer.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String? gender;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final int ID;

  @HiveField(4)
  final int? level;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final Uint8List? imageBytes;

  Customer({
    required this.fullName,
    this.gender,
    required this.email,
    required this.ID,
    this.level,
    required this.password,
    this.imageBytes,
  });
}
