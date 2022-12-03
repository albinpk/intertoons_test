import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Slider banner model
class SliderBanner extends Equatable {
  const SliderBanner({
    required this.id,
    required this.bannerOrder,
    required this.bannerImg,
  });

  /// Banner id.
  final int id;

  /// Banner order.
  final String bannerOrder;

  /// Banner image.
  final String bannerImg;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'banner_order': bannerOrder,
      'banner_img': bannerImg,
    };
  }

  factory SliderBanner.fromMap(Map<String, dynamic> map) {
    return SliderBanner(
      id: map['id'] as int,
      bannerOrder: map['banner_order'] as String,
      bannerImg: map['banner_img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderBanner.fromJson(String source) =>
      SliderBanner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [id, bannerOrder, bannerImg];
}
