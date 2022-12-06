import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../types.dart';

class ProductsRepository {
  /// Fetch all products from api.
  Future<MapData> fetchProducts() {
    return http.post(
      Uri.parse('$apiBase/products'),
      headers: {'Authorization': authToken},
      body: {"pagesize": "100"},
    ).then<MapData>((res) => json.decode(res.body) as MapData);
  }
}
