import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:get_it/get_it.dart';

import '../../modules/home/data/data_source/drinks_remote_data_source.dart';
import '../../modules/home/data/repository/home_repository_impl.dart';
import '../../modules/home/domain/repository/home_repository.dart';
import '../../modules/home/domain/usecases/get_drinks.dart';
import '../../modules/home/domain/usecases/search_drinks.dart';
import '../constants/app/constants.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  // services
  serviceLocator.registerSingleton<ApiService>(ApiService(baseUrl: Constants.BASE_URL));
  serviceLocator.registerSingleton<NavigationService>(NavigationService());

  // use cases
  serviceLocator.registerFactory(() => GetDrinks());
  serviceLocator.registerFactory(() => SearchDrinks());

  // repositories
  serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl());

  // data sources
  serviceLocator.registerFactory<DrinksRemoteDataSource>(
      () => DrinksRemoteDataSourceImpl());
}
