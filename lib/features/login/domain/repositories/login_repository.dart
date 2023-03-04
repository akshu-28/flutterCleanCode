import 'package:dartz/dartz.dart';
import 'package:fluttercleancode/features/login/data/models/login_request.dart';

import '../../../../core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> loginUser({required LoginRequest parameters});
}
