import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info_impl.dart';
import 'package:study_flutter_clean_architeture/core/util/input_converter.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  _initFeatures();
  _initRepositories();
  _initDataSources();
  _initCore();
  await _initExternalDependencies();
}

void _initFeatures() {
  serviceLocator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: serviceLocator(),
      getRandomNumberTrivia: serviceLocator(),
      inputConverter: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetConcreteNumberTrivia>(
      () => GetConcreteNumberTrivia(serviceLocator()));
  serviceLocator.registerLazySingleton<GetRandomNumberTrivia>(
      () => GetRandomNumberTrivia(serviceLocator()));
}

void _initRepositories() {
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
}

void _initDataSources() {
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImplementation(client: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImplementation(),
  );
}

void _initCore() {
  serviceLocator.registerLazySingleton<InputConverter>(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: serviceLocator()));
}

Future<void> _initExternalDependencies() async {
  serviceLocator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  serviceLocator.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
