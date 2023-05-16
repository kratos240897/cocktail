import 'package:bloc/bloc.dart';
import 'package:cocktail/core/app/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'core/base/service_locator.dart';
import 'core/app/my_app.dart';

void main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  await setUpServiceLocator();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
