import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercleancode/features/watchlist/domain/usecases/watchlist_usecase.dart';
import 'package:fluttercleancode/features/watchlist/presentation/bloc/watchlist_state.dart';

import '../../../../core/constants/error_constants.dart';
import '../../../../core/error/failure.dart';

part 'watchlist_event.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistUsecase watchlistUsecase;

  WatchlistBloc(this.watchlistUsecase) : super(WatchlistInitial()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoad());

      final result = await watchlistUsecase.execute();

      result.fold((l) {
        emit(WatchlistError(message: _getErrorMessage(l)));
      }, (r) => emit(WatchlistDone(r)));
    });
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;

      default:
        return ErrorType.unknownError;
    }
  }
}
