import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercleancode/features/watchlist/domain/usecases/watchlist_usecase.dart';
import 'package:fluttercleancode/features/watchlist/presentation/bloc/watchlist_state.dart';

part 'watchlist_event.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistUsecase watchlistUsecase;

  WatchlistBloc(this.watchlistUsecase) : super(WatchlistInitial()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoad());
      try {
        final result = await watchlistUsecase.execute();

        emit(result.fold((l) => WatchlistError(), (r) => WatchlistDone(r)));
      } catch (e) {
        emit(WatchlistError());
        throw ("error");
      }
    });
  }
}
