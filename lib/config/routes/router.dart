import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injection_container.dart';
import '../../../features/data/models/cocktail_response.dart';
import '../../../features/presentation/pages/detail.dart';
import '../../features/presentation/bloc/home/home_bloc.dart';
import '../../features/presentation/pages/home.dart';
import 'routes.dart';

final router = GoRouter(initialLocation: AppRoutes.home, routes: [
  GoRoute(
    name: AppRouteNames.home,
    path: AppRoutes.home,
    pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider<HomeBloc>(
            create: (context) => sl(), child: const Home())),
  ),
  GoRoute(
    name: AppRouteNames.detail,
    path: AppRoutes.detail,
    pageBuilder: (context, state) => MaterialPage(
        child: Detail(drink: state.extra as Drink)),
  )
]);

Route? onGenerateRoute(RouteSettings settings) {
  final route = settings.name;
  final args = settings.arguments;

  switch (route) {
    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (context) => BlocProvider<HomeBloc>(
            create: (context) => sl(), child: const Home()),
      );
    case AppRoutes.detail:
      return MaterialPageRoute(
          builder: (context) => Detail(drink: args as Drink));
  }
  return null;
}
