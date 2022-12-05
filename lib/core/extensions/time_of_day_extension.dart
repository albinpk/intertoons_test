import 'package:flutter/material.dart';

/// TimeOfDay extension.
extension TimeOfDayX on TimeOfDay {
  /// Convert [TimeOfDay] to string format like `"12:10"`.
  String toStringShort() => '$hour:$minute';

  /// Convert a string format like `"12:10"` to [TimeOfDay].
  static TimeOfDay fromString(String value) {
    final list = value.split(':');
    return TimeOfDay(
      hour: int.tryParse(list[0]) ?? 0,
      minute: int.tryParse(list[1]) ?? 0,
    );
  }
}
