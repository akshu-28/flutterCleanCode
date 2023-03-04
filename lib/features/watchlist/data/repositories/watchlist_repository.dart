import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/watchlist/data/models/watchlist_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WatchlistModel>> getwatchlist() async {
    try {
      final response = await remoteDataSource.getwatchlist();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
