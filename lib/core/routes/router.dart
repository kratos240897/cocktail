import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/detail/detail.dart';
import '../../modules/home/data/models/cocktail_response.dart';
import '../../modules/home/presentation/bloc/home_bloc.dart';
import '../../modules/home/presentation/home.dart';
import 'routes.dart';

Route? onGenerateRoute(RouteSettings settings) {
  final route = settings.name;
  final args = settings.arguments;

  switch (route) {
    case Routes.HOME:
      return MaterialPageRoute(
        builder: (context) =>
            BlocProvider(create: (context) => HomeBloc(), child: const Home()),
      );
    case Routes.DETAIL:
      return MaterialPageRoute(
          builder: (context) => Detail(drink: args as Drinks));
  }
  return null;
}
