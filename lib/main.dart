import 'package:flutter/material.dart';
import 'package:fluttercleancode/features/login/data/repositories/login_repository.dart';
import 'package:fluttercleancode/features/login/domain/repositories/login_repository.dart';
import 'package:fluttercleancode/features/login/domain/usecases/login_user.dart';
import 'package:fluttercleancode/features/login/presentation/bloc/login_bloc.dart';
import 'package:fluttercleancode/features/watchlist/data/repositories/watchlist_repository.dart';
import 'package:fluttercleancode/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:fluttercleancode/features/watchlist/domain/usecases/watchlist_usecase.dart';
import 'package:fluttercleancode/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/router/router.dart';
import 'features/login/data/datasources/login_remote.dart';
import 'features/watchlist/data/datasources/watchlist_remote.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl());
  sl.registerLazySingleton<WatchlistDataSource>(
      () => WatchlistDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<WatchlistRepository>(() => WatchlistRepositoryImpl(
        remoteDataSource: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => WatchlistUsecase(repository: sl()));

  // BLoC
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => WatchlistBloc(sl()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.routelogin,
            title: "Flutter clean architecture",
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
