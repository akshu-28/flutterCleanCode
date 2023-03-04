import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/watchlist/data/models/watchlist_model.dart';

import '../../../../core/error/failure.dart';
import '../repositories/watchlist_repository.dart';

class WatchlistUsecase {
  final WatchlistRepository repository;

  WatchlistUsecase({required this.repository});

  Future<Either<Failure, WatchlistModel>> execute() async {
    return repository.getwatchlist();
  }
}
