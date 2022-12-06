import 'dart:developer';

import '../types.dart';

mixin JsonExtractionMixin {
  /// Extract and return the list of [T] contained in the [key]
  /// from the given [map] using the [converter] function.
  List<T> extractListFromJson<T>(
    MapData map,
    String key,
    T Function(MapData map) converter,
  ) {
    try {
      if (!(map['data'] as MapData).containsKey(key)) {
        throw 'No $key in the json';
      }

      return (map['data'][key] as List)
          .map<T>((e) => converter(e as MapData))
          .toList();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
