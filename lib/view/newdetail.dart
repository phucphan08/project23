import 'package:flutter/material.dart';
import 'package:flutter_application_test23/model/newsmodel.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: const Text(APP_BAR_TITLE),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              ImageView(context),
              RoundedBox(),
              Positioned(bottom: 5, right: 0, child: LinkButton())
            ]),
            Padding(
                padding: const EdgeInsets.only(
                    top: 4, right: 0, left: 15, bottom: 15),
                child: Column(
                  children: [
                    AuthorAndData(context),
                    Body(context),
                  ],
                ))
            //  Floating button
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ImageView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(news.url)),
        // NetworkImage(news.urlToImage ?? ImageURLS.DEFAULT_IMG_URL)),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget RoundedBox() {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(20))),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LinkButton() {
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
    final Uri url = Uri.parse(news.urlNews);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // ignore: non_constant_identifier_names
  Widget AuthorAndData(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(news.title,
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis)),
        Flexible(
            child: Text(news.date,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis))
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(news.title,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(news.description,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis),
        )
      ],
    );
  }

  // ignore: constant_identifier_names
  static const APP_BAR_TITLE = "News details";
}
