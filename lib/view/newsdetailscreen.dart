import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/newsmodel.dart';

class NewDetailsPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NewDetailsPage(this.news);
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return ScreenArticleDetails(news: news);
  }
}

class ScreenArticleDetails extends StatelessWidget {
  final NewsModel news;

  const ScreenArticleDetails({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              imageView(context),
              roundedBox(),
              Positioned(bottom: 0, right: 0, child: linkButton())
            ]),
            Padding(
                padding: const EdgeInsets.only(
                    top: 4, right: 0, left: 15, bottom: 15),
                child: Column(
                  children: [
                    titleAnddate(context),
                    body(context),
                  ],
                ))
            //  Floating button
          ],
        ),
      ),
    );
  }

  Widget imageView(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: CachedNetworkImage(
          imageUrl: news.image ??
              "https://www.dohanews.co/wp-content/uploads/2022/03/Screenshot-2022-03-07-at-11.37.34-AM-140x140.png",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              const SizedBox(width: 550, child: Icon(Icons.error)),
        ));
  }

  Widget roundedBox() {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(20))),
    );
  }

  Widget linkButton() {
    return RawMaterialButton(
      onPressed: _launchURL,
      elevation: 2.0,
      fillColor: Colors.white,
      child: const Icon(
        Icons.open_in_browser,
        size: 35.0,
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(10.0),
      shape: const CircleBorder(),
    );
  }

  _launchURL() async {
    final Uri url = Uri.parse(news.url ?? "google.com");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget titleAnddate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(news.title ?? "Title",
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis)),
        Flexible(
            child: Text(news.publicAt ?? "9/9/1999",
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis))
      ],
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            news.title ?? "Title",
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            news.description ?? "des",
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
        )
      ],
    );
  }

  static const appBarTitle = "News details";
}
