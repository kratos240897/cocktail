import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';

import 'core/base/service_locator.dart';
import 'core/constants/app/styles.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';

void main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );
  await setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cocktail',
            theme: ThemeData(
                primarySwatch: Styles.colors.kPrimaryColor,
                fontFamily: GoogleFonts.poppins().fontFamily),
            onGenerateRoute: onGenerateRoute,
            initialRoute: Routes.HOME,
          );
        });
  }
}
