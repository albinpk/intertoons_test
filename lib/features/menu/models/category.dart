import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Category model.
class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.child,
  });

  /// Category id.
  final int id;

  /// Category name.
  final String name;

  /// Category image.
  final String imageUrl;

  /// Category child.
  final List child;

  @override
  List<Object> get props => [id, name, imageUrl, child];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _kId: id,
      _kName: name,
      _kImageUrl: imageUrl,
      _kChild: child,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map[_kId] as int,
      name: map[_kName] as String,
      imageUrl: map[_kImageUrl] as String,
      child: map[_kChild] == null
          ? []
          : List<CategoryChild>.from(
              (map[_kChild] as List).map<CategoryChild>(
                (e) => CategoryChild.fromMap(e),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  static const _kId = 'cat_id';
  static const _kName = 'cat_name';
  static const _kImageUrl = 'cat_img';
  static const _kChild = 'child_data';
}

/// [Category.child] model.
class CategoryChild extends Equatable {
  const CategoryChild({
    required this.id,
    required this.name,
    required this.status,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final bool status;
  final String imageUrl;

  @override
  List<Object> get props => [id, name, status, imageUrl];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _kId: id,
      _kName: name,
      _kStatus: status,
      _kImageUrl: imageUrl,
    };
  }

  factory CategoryChild.fromMap(Map<String, dynamic> map) {
    return CategoryChild(
      id: map[_kId] as int,
      name: map[_kName] as String,
      status: map[_kStatus] as bool,
      imageUrl: map[_kImageUrl] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryChild.fromJson(String source) =>
      CategoryChild.fromMap(json.decode(source) as Map<String, dynamic>);

  static const _kId = 'cat_id';
  static const _kName = 'cat_name';
  static const _kStatus = 'cat_status';
  static const _kImageUrl = 'cat_image';
}
