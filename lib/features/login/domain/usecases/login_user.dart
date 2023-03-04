import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/login/data/models/login_request.dart';
import 'package:fluttercleancode/features/login/domain/repositories/login_repository.dart';

import '../../../../core/error/failure.dart';

class LoginUser {
  final LoginRepository repository;

  LoginUser({required this.repository});

  Future<Either<Failure, String>> execute(
      {required LoginRequest parameters}) async {
    return repository.loginUser(parameters: parameters);
  }
}
