import 'package:fluttercleancode/features/watchlist/data/models/watchlist_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/httpImpl/http_connection.dart';

abstract class WatchlistDataSource {
  Future<WatchlistModel> getwatchlist();
}

class WatchlistDataSourceImpl implements WatchlistDataSource {
  @override
  Future<WatchlistModel> getwatchlist() async {
    final data = await HttpConnect.get(path: ApiConstants.watchlistUrl);

    return WatchlistModel.fromJson(data);
  }
}
