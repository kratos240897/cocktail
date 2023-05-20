import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'core/base/service_locator.dart';
import 'core/app/my_app.dart';

void main() async {
  EvolveX.init();
  await setUpServiceLocator();
  runApp(const MyApp());
}
