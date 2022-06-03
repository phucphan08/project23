import './repo/news_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import './bloc/infinite_load_bloc.dart';
import 'bloc/infinite_load_bloc.dart';
import 'view/news_item.dart';
import './model/newsmodel.dart';

void main() {
  runApp(
    BlocProvider<InfiniteLoadBloc>(
      create: (context) => InfiniteLoadBloc(NewRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InfiniteLoadBloc _bloc;
  late int _currentLenght;
  List<NewsModel> _data = [];

  void _loadMoreData() {
    _bloc.add(GetMoreInfiniteLoad(_currentLenght, 10));
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<InfiniteLoadBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: BlocBuilder<InfiniteLoadBloc, InfiniteLoadState>(
        builder: (context, state) {
          if (state is InfiniteLoadInitial) {
            context.read<InfiniteLoadBloc>().add(GetInfiniteLoad());
          }
          if (state is InfiniteLoadLoaded || state is InfiniteLoadMoreLoading) {
            if (state is InfiniteLoadLoaded) {
              _data = state.data;
              _currentLenght = state.count;
            }
            return _buildListNews(state);
          } else if (state is InfiniteLoadLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoInternet) {
            return Center(
                child: Column(
              children: <Widget>[
                const Text('Check your internet'),
                TextButton(
                    onPressed: () => _bloc.add(GetInfiniteLoad()),
                    child: const Text("Try load again"))
              ],
            ));
          } else {
            return Center(
                child: Column(
              children: <Widget>[
                const Text('Load error'),
                TextButton(
                    onPressed: () => _bloc.add(GetInfiniteLoad()),
                    child: const Text("Try load again"))
              ],
            ));
            // const Center(child: Text("Error"), );
          }
        },
      ),
    );
  }

  Widget _buildListNews(InfiniteLoadState state) {
    return LazyLoadScrollView(
      onEndOfPage: () => _loadMoreData(),
      child: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _data.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return NewItem(data: _data[i]);
              }),
          (state is InfiniteLoadMoreLoading)
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
        ],
      ),
    );
  }
}
