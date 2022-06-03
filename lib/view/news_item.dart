// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/newsmodel.dart';
import '../view/newsdetailscreen.dart';

class NewItem extends StatelessWidget {
  final NewsModel data;

  const NewItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 4),
      leading: CachedNetworkImage(
        imageUrl: data.image ??
            "https:\/\/www.dohanews.co\/wp-content\/uploads\/2022\/03\/Screenshot-2022-03-07-at-11.37.34-AM-140x140.png",
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            const SizedBox(width: 70, child: Icon(Icons.error)),
      ),
      title: Text(data.title ?? "Title",
          overflow: TextOverflow.ellipsis, maxLines: 2),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.description ?? "Description",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 16, color: Colors.amber, fontWeight: FontWeight.w200),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.publicAt ?? "8/8/1999",
              // DateFormat('d/M/y').parse(data.publicAt).toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w200),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenArticleDetails(news: data)),
        );
      },
    );
  }
}
