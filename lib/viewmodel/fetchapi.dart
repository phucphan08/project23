// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter_application_test23/model/newsmodel.dart';
import 'package:http/http.dart';

class News {
  // save json data inside this
  List<NewsModel> datatobesavedin = [];

  Future<void> getNews() async {
    var response = await get(Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=4dc1721f4034ac07e4fbbc52d5fb6983'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData['data'].forEach((element) {
        if (element['description'] != null) {
          NewsModel articleModel = NewsModel(
              title: element['title'],
              date: element['published_at'],
              description: element['description'],
              url: element["image"] ??
                  "https://akhbarak.net/photos/articles-photos/2022/2/4/43522782/43522782-large.jpg?1643982454",
              urlNews: element["url"] ??
                  "https://akhbarak.net/photos/articles-photos/2022/2/4/43522782/43522782-large.jpg?1643982454");

          datatobesavedin.add(articleModel);
        }
      });
    } else {
      throw Exception(
          'Failed load data with status code ${response.statusCode}');
    }
  }
}
