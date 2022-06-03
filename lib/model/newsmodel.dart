import 'package:intl/intl.dart';

List<NewsModel> newsModelFromJson(var str) =>
    List<NewsModel>.from(str.map((x) => NewsModel.fromJson(x)));

class NewsModel {
  NewsModel({
    this.title,
    this.url,
    this.image,
    this.publicAt,
    this.description,
  });
  final String? image;
  final String? publicAt;
  final String? title;
  final String? url;
  final String? description;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      title: json["title"],
      url: json["url"],
      image: json["image"] ??
          "https://akhbarak.net/News/articles-News/2022/2/4/43522782/43522782-large.jpg?1643982454",
      publicAt: DateFormat("yMd").format(DateTime.parse(json["published_at"])),
      description: json["description"]);
}
