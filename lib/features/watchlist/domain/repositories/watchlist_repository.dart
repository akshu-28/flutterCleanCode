import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/watchlist/data/models/watchlist_model.dart';

import '../../../../core/error/failure.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, WatchlistModel>> getwatchlist();
}
