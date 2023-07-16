import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_consumer.dart';
import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Externals
  await _initExternals();
  //! Core
  _initCore();
  //! Features
  _initTriviaFeature();
}

_initExternals() async {
  // Dio
  sl.registerLazySingleton(() => Dio());
  // InternetConnectionChecker
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

_initCore() {
  // Api consumer
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl()));
  // Input Converter
  sl.registerLazySingleton(() => InputConverter());
  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

_initTriviaFeature() {
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sl()),
  );
  // Repositories
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      networkInfo: sl(),
      numberTriviaLocalDataSource: sl(),
      numberTriviaRemoteDataSource: sl(),
    ),
  );
  // Usecases
  sl.registerLazySingleton(
    () => GetConcreteNumberTrivia(sl()),
  );
  sl.registerLazySingleton(
    () => GetRandomNumberTrivia(sl()),
  );
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );
}
