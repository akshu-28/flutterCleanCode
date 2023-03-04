import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/login/data/datasources/login_remote.dart';
import 'package:fluttercleancode/features/login/data/models/login_request.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> loginUser(
      {required LoginRequest parameters}) async {
    try {
      final response = await remoteDataSource.loginUser(parameters: parameters);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
