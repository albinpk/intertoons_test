import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intertoons_test/core/types.dart';

import '../../../core/constants.dart';

class HomeRepository {
  /// Fetch home data from api.
  Future<MapData> fetchHomeData() {
    return http.get(
      Uri.parse('$apiBase/home'),
      headers: {'Authorization': authToken},
    ).then<MapData>((res) => json.decode(res.body) as MapData);
  }
}
