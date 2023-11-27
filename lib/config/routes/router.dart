import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/domain/entities/drink.dart';
import '../../features/presentation/cubit/home_cubit.dart';
import '../../features/presentation/pages/detail.dart';
import '../../features/presentation/pages/home_view.dart';

final router = GoRouter(initialLocation: HomeView.route, routes: [
  GoRoute(
    name: HomeView.routeName,
    path: HomeView.route,
    pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider<HomeCubit>(
            create: (context) => sl(), child: const HomeView())),
  ),
  GoRoute(
    name: DetailView.routeName,
    path: DetailView.route,
    pageBuilder: (context, state) =>
        MaterialPage(child: DetailView(drink: state.extra as Drink)),
  )
]);
