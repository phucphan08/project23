part of 'infinite_load_bloc.dart';

@immutable
abstract class InfiniteLoadEvent extends Equatable {
  const InfiniteLoadEvent();

  @override
  List<Object> get props => [];
}

class GetInfiniteLoad extends InfiniteLoadEvent {}

class GetMoreInfiniteLoad extends InfiniteLoadEvent {
  final int start, limit;

  const GetMoreInfiniteLoad(this.start, this.limit);
  @override
  List<Object> get props => [start, limit];
}
