import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../model/newsmodel.dart';
import '../repo/news_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'infinite_load_event.dart';
part 'infinite_load_state.dart';

class InfiniteLoadBloc extends Bloc<InfiniteLoadEvent, InfiniteLoadState> {
  final NewRepository newRepository;
  List<NewsModel> data = [];
  int currentLenght = 0;
  InfiniteLoadBloc(
    this.newRepository,
  ) : super(InfiniteLoadInitial()) {
    on<InfiniteLoadEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(NoInternet());
      } else if (event is GetInfiniteLoad) {
        if (currentLenght != 0) {
          emit(InfiniteLoadMoreLoading());
        } else {
          emit(InfiniteLoadLoading());
          final List<NewsModel> apiResult = await newRepository.getNews(0, 10);
          if (apiResult.isNotEmpty) {
            data.addAll(apiResult);
            if (currentLenght != 0) {
              currentLenght += apiResult.length;
            } else {
              currentLenght = apiResult.length;
            }
          }
        }

        emit(InfiniteLoadLoaded(data, currentLenght));
      } else if (event is GetMoreInfiniteLoad) {
        if (currentLenght != 0) {
          emit(InfiniteLoadMoreLoading());
          final List<NewsModel> apiResult =
              await newRepository.getNews(event.start, event.limit);
          if (apiResult.isNotEmpty) {
            data.addAll(apiResult);
            if (currentLenght != 0) {
              currentLenght += apiResult.length;
            } else {
              currentLenght = apiResult.length;
            }
          }
        } else {
          emit(InfiniteLoadLoading());
        }
        emit(InfiniteLoadLoaded(data, currentLenght));
      }
    });
  }
}
