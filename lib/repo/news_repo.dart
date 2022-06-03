import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/newsmodel.dart';

class NewRepository {
  Future<List<NewsModel>> getNews(int start, int limit) async {
    String url =
        "http://api.mediastack.com/v1/news?access_key=4dc1721f4034ac07e4fbbc52d5fb6983&start=$start&limit=$limit";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());

      return newsModelFromJson(json["data"]);
    } else {
      return [];
    }
  }
}
