import 'package:fluttercleancode/core/constants/response_constants.dart';
import 'package:fluttercleancode/features/login/data/models/login_request.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/httpImpl/http_connection.dart';

abstract class LoginDataSource {
  Future<String> loginUser({required LoginRequest parameters});
}

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<String> loginUser({required LoginRequest parameters}) async {
    await HttpConnect.post(path: ApiConstants.loginUrl, body: {
      "request": {
        "data": {"mobNo": parameters.userName},
        "appID": "f79f65f1b98e116f40633dbb46fd5e21"
      }
    });
    return ResponseConst.loggedIn;
  }
}
