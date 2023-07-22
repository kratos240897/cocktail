import 'package:dio/dio.dart';
import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get_it/get_it.dart';

import '../config/theme/theme_bloc.dart';
import '../features/data/data_source/remote/drinks_api_service.dart';
import '../features/data/repository/home_repository_impl.dart';
import '../features/domain/repository/home_repository.dart';
import '../features/domain/usecases/get_drinks_use_case.dart';
import '../features/domain/usecases/search_drinks_use_case.dart';
import '../features/presentation/bloc/home/home_bloc.dart';


final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  sl.registerSingleton<NavigationService>(NavigationService());

  sl.registerSingleton<Dio>(Dio()..interceptors.add(LoggyDioInterceptor()));

  sl.registerSingleton<DrinksApiService>(DrinksApiService(sl()));

  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl()));

  sl.registerSingleton(GetDrinksUseCase(sl()));
  sl.registerSingleton(SearchDrinksUseCase(sl()));

  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => HomeBloc(sl(), sl()));
}
