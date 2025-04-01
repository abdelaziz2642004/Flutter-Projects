import 'package:uuid/uuid.dart';

class Coffee {
  final String _id;
  final String _name;
  final String _description;
  final double _rating;
  final double _smallPrice;
  final double _mediumPrice;
  final double _largePrice;

  final String _imageUrl;
  final List<String> _categoryIDs;
  final int _ratingCount;

  final bool _isSugary;
  final bool _isDairy;
  final bool _isDecaf;
  final bool _containsNuts;
  final bool _containsCaffeine;

  Coffee({
    required String name,
    required String description,
    required double smallPrice,
    required double mediumPrice,
    required double largePrice,
    required String imageUrl,
    required List<String> categoryIDs,
    required double rating,
    String? id,

    int ratingCount = 89,
    bool isSugary = true,
    bool isDairy = true,
    bool isDecaf = true,
    bool containsNuts = true,
    bool containsCaffeine = true,
  }) : _name = name,
       _description = description,
       _smallPrice = smallPrice,
       _mediumPrice = mediumPrice,
       _largePrice = largePrice,
       _imageUrl = imageUrl,
       _categoryIDs = categoryIDs,
       _rating = rating,
       _ratingCount = ratingCount,
       _isSugary = isSugary,
       _isDairy = isDairy,
       _isDecaf = isDecaf,
       _containsNuts = containsNuts,
       _containsCaffeine = containsCaffeine,
       _id = id ?? const Uuid().v4();

  String get id => _id;
  String get name => _name;
  String get description => _description;
  double get rating => _rating;
  int get ratingCount => _ratingCount;
  String get imageUrl => _imageUrl;
  List<String> get categoryIDs => _categoryIDs;

  bool get isSugary => _isSugary;
  bool get isDairy => _isDairy;
  bool get isDecaf => _isDecaf;
  bool get containsNuts => _containsNuts;
  bool get containsCaffeine => _containsCaffeine;

  double getPrice(String size) {
    return size == 'L'
        ? _largePrice
        : size == 'M'
        ? _mediumPrice
        : _smallPrice;
  }
}

enum filters { isSugary, isDairy, isDecaf, containsNuts, containsCaffeine }
