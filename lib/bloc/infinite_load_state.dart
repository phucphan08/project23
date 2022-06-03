part of 'infinite_load_bloc.dart';

@immutable
abstract class InfiniteLoadState extends Equatable {
  const InfiniteLoadState();
  @override
  List<Object> get props => [];
}

class InfiniteLoadInitial extends InfiniteLoadState {}

class InfiniteLoadLoading extends InfiniteLoadState {}

class InfiniteLoadMoreLoading extends InfiniteLoadState {}

class InfiniteLoadLoaded extends InfiniteLoadState {
  final List<NewsModel> data;
  final int count;

  const InfiniteLoadLoaded(this.data, this.count);
  @override
  List<Object> get props => [data, count];
}

class InfiniteLoadError extends InfiniteLoadState {}

class NoInternet extends InfiniteLoadState {}
