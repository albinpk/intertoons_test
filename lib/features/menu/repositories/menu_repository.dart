import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intertoons_test/core/types.dart';

import '../../../core/constants.dart';

class MenuRepository {
  /// Fetch menu data from api.
  Future<MapData> fetchMenuData() {
    return http.get(
      Uri.parse('$apiBase/categories'),
      headers: {'Authorization': authToken},
    ).then<MapData>((res) => json.decode(res.body) as MapData);
  }
}
