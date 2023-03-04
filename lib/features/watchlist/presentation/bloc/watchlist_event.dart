part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

class FetchWatchlist extends WatchlistEvent {
  const FetchWatchlist();
  @override
  List<Object?> get props => [];
}
