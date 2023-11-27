import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'core/app/my_app.dart';

void main() async {
  EvolveX.init();
  await initializeDependencies();
  runApp(const MyApp());
}
