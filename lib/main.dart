import 'package:flutter/material.dart';
import 'package:flutter_application_test23/model/newsmodel.dart';
import 'package:flutter_application_test23/view/newdetail.dart';
import 'package:flutter_application_test23/viewmodel/fetchapi.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> newslist = <NewsModel>[];
  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    newslist = newsdata.datatobesavedin;
    setState(() {
      // _loading = false;
      newslist = newsdata.datatobesavedin;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'News',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            newslist.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: newslist.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.all(10),
                            child: NewsTile(newslist[index]));
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final NewsModel news;
  // ignore: use_key_in_widget_constructors
  const NewsTile(this.news);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 4),
      leading: CachedNetworkImage(
        imageUrl: news.url,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(news.title, overflow: TextOverflow.ellipsis, maxLines: 2),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 16, color: Colors.amber, fontWeight: FontWeight.w200),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              news.date,
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
              builder: (context) => ScreenArticleDetails(news: news)),
        );
      },
    );
  }
}
