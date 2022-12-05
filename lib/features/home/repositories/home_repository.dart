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

  /// Fetch all products from api.
  Future<MapData> fetchProducts() {
    return http
        .post(
          Uri.parse('$apiBase/products'),
          headers: {'Authorization': authToken},
          body: json.encode({"currentpage": 1, "pagesize": 100}),
        )
        .then<MapData>((res) => json.decode(res.body) as MapData);
  }
}
