import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'store.g.dart';

@HiveType(typeId: 1)
class Store {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double rating;
  @HiveField(4)
  final double latitude;
  @HiveField(5)
  final double longitude;
  @HiveField(6)
  final Uint8List? imageBytes;

  Store({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.imageBytes,
  });
}
